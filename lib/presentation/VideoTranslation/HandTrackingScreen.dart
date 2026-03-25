
// import 'dart:convert';
// import 'package:flutter_mediapipe/flutter_mediapipe.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/main.dart';
// import 'package:flutter_mediapipe/flutter_mediapipe.dart';

// import 'package:hand_landmarker/hand_landmarker.dart';

// class HandTrackingScreen extends StatefulWidget {
//   const HandTrackingScreen({super.key});

//   @override
//   State<HandTrackingScreen> createState() => _HandTrackingScreenState();
// }

// class _HandTrackingScreenState extends State<HandTrackingScreen> {
//   late CameraController _cameraController;

//   // قائمة لتخزين كل Frames
//   List<List<double>> allFramesData = [];

//   // نعد الصور
//   int frameCount = 0;
//   final int maxFrames = 30; // نلتقط 30 صورة فقط

//   @override
//   void initState() {
//     super.initState();

//     _cameraController = CameraController(cameras[0], ResolutionPreset.medium);

//     _cameraController.initialize().then((_) {
//       setState(() {});

//       _cameraController.startImageStream((image) async {
//         if (frameCount >= maxFrames) return; // نوقف بعد 30 صورة

//         final results = await MediaPipe.processImage(image);

//         List<double> handsPointsCombined = [];

//         // اليد أو اليدين معًا
//         for (var hand in results.hands) {
//           for (var point in hand.landmarks) {
//             handsPointsCombined.add(point.x);
//             handsPointsCombined.add(point.y);
//             handsPointsCombined.add(point.z);
//           }
//         }

//         if (handsPointsCombined.isNotEmpty) {
//           allFramesData.add(handsPointsCombined);
//           frameCount++;
//         }

//         // بعد ما نوصل لـ 30 صورة
//         if (frameCount == maxFrames) {
//           String jsonData = jsonEncode(allFramesData);

//           print("JSON النهائي بعد 30 Frame:");
//           print(jsonData);

//           // إرسال JSON للسيرفر
//           // await http.post(Uri.parse('https://your-server.com/hand-data'),
//           //     headers: {'Content-Type': 'application/json'}, body: jsonData);

//           // ممكن توقف البث بعد جمع الـ 30 Frame
//           _cameraController.stopImageStream();
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _cameraController.value.isInitialized
//           ? CameraPreview(_cameraController)
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }


// class HandTrackingScreen extends StatefulWidget {
//   const HandTrackingScreen({super.key});
//   @override
//   _HandTrackingScreenState createState() => _HandTrackingScreenState();
// }

// class _HandTrackingScreenState extends State<HandTrackingScreen> {
//   CameraController? _cameraController;
//   HandLandmarkerPlugin? _handLandmarker;
//   bool _isDetecting = false;

//   List<List<double>> allFramesData = [];
//   int frameCount = 0;
//   final int maxFrames = 30;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCameraAndModel();
//   }

//     Future<void> initModel() async {
//   _handLandmarker = await HandLandmarkerPlugin.create();
// }
//   Future<void> _initializeCameraAndModel() async {
//     // 1️⃣ تهيئة الكاميرا
//     _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
//     await _cameraController!.initialize();

//     // 2️⃣ تهيئة الـ HandLandmarker

//     // 3️⃣ بدء بث الكاميرا
//     _cameraController!.startImageStream(_processCameraImage);

//     setState(() {});
//   }

//   void _processCameraImage(CameraImage image) async {
//     if (_isDetecting || frameCount >= maxFrames) return;

//     _isDetecting = true;

//     try {
//       // 4️⃣ نمرر الصورة لـ hand_landmarker
//       final hands = _handLandmarker!.detect(
//         image,
//         _cameraController!.description.sensorOrientation,
//       );

//       List<double> combined = [];

//       // كل Hand في hands عبارة عن كائن فيه landmarks
//       for (var hand in hands) {
//         for (var lm in hand.landmarks) {
//           combined.add(lm.x);
//           combined.add(lm.y);
//           combined.add(lm.z);
//         }
//       }

//       if (combined.isNotEmpty) {
//         allFramesData.add(combined);
//         frameCount++;
//       }

//       // بعد 30 Frame
//       if (frameCount == maxFrames) {
//         String jsonData = jsonEncode(allFramesData);
//         print("JSON النهائي بعد 30 صورة:");
//         print(jsonData);

//         // مثال: ترسليها للسيرفر
//         // await http.post(
//         //   Uri.parse('https://your-server.com/hand-data'),
//         //   headers: {'Content-Type': 'application/json'},
//         //   body: jsonData,
//         // );

//         // تبطي المعالجة لو عايزة
//         _cameraController!.stopImageStream();
//       }
//     } catch (e) {
//       print("Error detecting hand landmarks: $e");
//     }

//     _isDetecting = false;
//   }

//   @override
//   void dispose() {
//     _cameraController?.dispose();
//     _handLandmarker?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _cameraController != null && _cameraController!.value.isInitialized
//           ? CameraPreview(_cameraController!)
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }