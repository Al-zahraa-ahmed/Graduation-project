import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

// class CameraBoxScreen extends StatefulWidget {
//   const CameraBoxScreen({super.key});

//   @override
//   State<CameraBoxScreen> createState() => _CameraBoxScreenState();
// }

// class _CameraBoxScreenState extends State<CameraBoxScreen> {
//   CameraController? controller;
//   List<CameraDescription> cameras = [];

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     cameras = await availableCameras();

//     controller = CameraController(
//       cameras[0],
//       ResolutionPreset.high,
//     );

//     await controller!.initialize();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller!.value.isInitialized) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       body: Stack(
//         children: [

//           /// الكاميرا
//           SizedBox.expand(
//             child: CameraPreview(controller!),
//           ),

//           /// طبقة Blur
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(
//               color: Colors.black.withOpacity(0.3),
//             ),
//           ),

//           /// المربع الواضح
//           Center(
//             child: Container(
//               width: 250,
//               height: 250,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 3),
//                 color: Colors.transparent,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// late List<CameraDescription> cameras;


// class CameraBoxScreen extends StatefulWidget {
//   const CameraBoxScreen({super.key});

//   @override
//   State<CameraBoxScreen> createState() => _CameraBoxScreenState();
// }

// class _CameraBoxScreenState extends State<CameraBoxScreen> {
//   CameraController? controller;

//   @override
//   void initState() {
//     super.initState();
//     initCamera();
//   }

//   Future<void> initCamera() async {
//     controller = CameraController(
//       cameras[0],
//       ResolutionPreset.high,
//     );

//     await controller!.initialize();

//     if (!mounted) return;

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   Widget blurArea() {
//     return ClipRect(
//       child: BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaX: 8,
//           sigmaY: 8,
//         ),
//         child: Container(
//           color: Colors.black.withOpacity(0.4),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (controller == null || !controller!.value.isInitialized) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     return Scaffold(
//       body: Stack(
//         children: [

//           /// الكاميرا
//           SizedBox.expand(
//             child: CameraPreview(controller!),
//           ),

//           /// Overlay
//           Column(
//             children: [

//               /// الجزء العلوي
//               Expanded(
//                 child: blurArea(),
//               ),

//               /// الجزء الأوسط
//               Row(
//                 children: [

//                   Expanded(
//                     child: blurArea(),
//                   ),

//                   /// المربع
//                   Container(
//                     width: 250,
//                     height: 250,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 4,
//                       ),
//                     ),
//                   ),

//                   Expanded(
//                     child: blurArea(),
//                   ),
//                 ],
//               ),

//               /// الجزء السفلي
//               Expanded(
//                 child: blurArea(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }