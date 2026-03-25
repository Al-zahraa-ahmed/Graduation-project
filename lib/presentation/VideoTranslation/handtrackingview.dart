import 'dart:async';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Import the plugin's main class.
import 'package:hand_landmarker/hand_landmarker.dart';

late List<CameraDescription> cameras;

class HandTrackerView extends StatefulWidget {
  const HandTrackerView({super.key});

  @override
  State<HandTrackerView> createState() => _HandTrackerViewState();
}

class _HandTrackerViewState extends State<HandTrackerView> {
  CameraController? _controller;
  HandLandmarkerPlugin? _plugin;

  List<Hand> _landmarks = [];

  bool _isInitialized = false;
  bool _isDetecting = false;

  // 🔴 لتجميع 30 frame
  List<List<double>> framesLandmarks = [];
  int frameCount = 0;
  final int maxFrames = 30;

  @override
  void initState()  {
    super.initState();
    Setup();
  }

  Future<void> Setup() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    cameras = await availableCameras();
    _initialize();
   
  }
  Future<void> _initialize()async{
 final camera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    ); 

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _plugin = HandLandmarkerPlugin.create(
      numHands: 2,
      minHandDetectionConfidence: 0.7,
      delegate: HandLandmarkerDelegate.gpu,
    );

    await _controller!.initialize();

    await _controller!.startImageStream(_processCameraImage);

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.stopImageStream();
    _controller?.dispose();
    _plugin?.dispose();
    super.dispose();
  }

  // 🔴 تحويل landmarks إلى vector 126
  List<double> extractLandmarks(List<Hand> hands) {
    List<double> vector = [];

    for (var hand in hands) {
      for (var lm in hand.landmarks) {
        vector.add(lm.x);
        vector.add(lm.y);
        vector.add(lm.z);
      }
    }

    // لو فيه يد واحدة نكمل zeros
    while (vector.length < 126) {
      vector.add(0.0);
    }

    return vector;
  }

  Future<void> _processCameraImage(CameraImage image) async {
    int frameSkip = 0;
    frameSkip++;

if (frameSkip % 3 != 0) return;

    if (_isDetecting || !_isInitialized || _plugin == null) return;

    _isDetecting = true;

    try {
      final hands = _plugin!.detect(
        image,
        _controller!.description.sensorOrientation,
      );

      // 🔴 استخراج vector
      List<double> vector = extractLandmarks(hands);

      // 🔴 تخزين frame
      framesLandmarks.add(vector);
      frameCount++;

      if (frameCount == maxFrames) {
        print("Collected 30 frames:");
        print(framesLandmarks); // هنا عندك List<List<double>>

        // مثال الحجم
        // 30 × 126

        frameCount = 0;
        framesLandmarks.clear();
      }

      if (mounted) {
        setState(() {
          _landmarks = hands;
        });
      }
    } catch (e) {
      debugPrint('Error detecting landmarks: $e');
    }

    _isDetecting = false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final controller = _controller!;
    final previewSize = controller.value.previewSize!;
    final previewAspectRatio = previewSize.height / previewSize.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Live Hand Tracking')),
      body: Center(
        child: AspectRatio(
          aspectRatio: previewAspectRatio,
          child: Stack(
            children: [
              CameraPreview(controller),
              CustomPaint(
                size: Size.infinite,
                painter: LandmarkPainter(
                  hands: _landmarks,
                  previewSize: previewSize,
                  lensDirection: controller.description.lensDirection,
                  sensorOrientation: controller.description.sensorOrientation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LandmarkPainter extends CustomPainter {
  LandmarkPainter({
    required this.hands,
    required this.previewSize,
    required this.lensDirection,
    required this.sensorOrientation,
  });

  final List<Hand> hands;
  final Size previewSize;
  final CameraLensDirection lensDirection;
  final int sensorOrientation;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / previewSize.height;

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8 / scale
      ..strokeCap = StrokeCap.round;

    final linePaint = Paint()
      ..color = Colors.lightBlueAccent
      ..strokeWidth = 4 / scale;

    canvas.save();

    final center = Offset(size.width / 2, size.height / 2);
    canvas.translate(center.dx, center.dy);
    canvas.rotate(sensorOrientation * math.pi / 180);

    if (lensDirection == CameraLensDirection.front) {
      canvas.scale(-1, 1);
      canvas.rotate(math.pi);
    }

    canvas.scale(scale);

    final logicalWidth = previewSize.width;
    final logicalHeight = previewSize.height;

    for (final hand in hands) {
      for (final landmark in hand.landmarks) {
        final dx = (landmark.x - 0.5) * logicalWidth;
        final dy = (landmark.y - 0.5) * logicalHeight;

        canvas.drawCircle(Offset(dx, dy), 8 / scale, paint);
      }

      for (final connection in HandLandmarkConnections.connections) {
        final start = hand.landmarks[connection[0]];
        final end = hand.landmarks[connection[1]];

        final startDx = (start.x - 0.5) * logicalWidth;
        final startDy = (start.y - 0.5) * logicalHeight;

        final endDx = (end.x - 0.5) * logicalWidth;
        final endDy = (end.y - 0.5) * logicalHeight;

        canvas.drawLine(
          Offset(startDx, startDy),
          Offset(endDx, endDy),
          linePaint,
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HandLandmarkConnections {
  static const List<List<int>> connections = [
    [0, 1],
    [1, 2],
    [2, 3],
    [3, 4],
    [0, 5],
    [5, 6],
    [6, 7],
    [7, 8],
    [5, 9],
    [9, 10],
    [10, 11],
    [11, 12],
    [9, 13],
    [13, 14],
    [14, 15],
    [15, 16],
    [13, 17],
    [0, 17],
    [17, 18],
    [18, 19],
    [19, 20],
  ];
}
