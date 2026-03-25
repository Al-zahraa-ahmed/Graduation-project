import 'package:flutter/material.dart';
import 'package:graduation_project/data/Services/HandLandmarker.dart';
// import 'HandChannel.dart';

class CameraScreen extends StatefulWidget {
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  List<List<double>> currentLandmarks = [];

  @override
  void initState() {
    super.initState();

    HandChannel.onNewFrame = (landmarks) {
      setState(() {
        currentLandmarks = landmarks;
      });
    };

    HandChannel.startCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hand Landmarks Realtime")),
      body: Center(
        child: Text("Landmarks count: ${currentLandmarks.length}"),
      ),
    );
  }
}