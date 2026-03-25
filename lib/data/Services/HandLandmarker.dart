import 'package:flutter/services.dart';

class HandLandmarkChannel {
  static const platform = MethodChannel('hand_landmarker');

  // اطلب landmark من native
  static Future<List<List<double>>> getHandLandmarks() async {
    try {
      final result = await platform.invokeMethod('getHandLandmarks');
      // result متوقع يكون List<List<double>>
      return List<List<double>>.from(
        (result as List).map(
          (e) => List<double>.from(e),
        ),
      );
    } on PlatformException catch (e) {
      print("Failed to get landmarks: '${e.message}'.");
      return [];
    }
  }
}


class HandChannel {

  static const channel = MethodChannel("hand_landmarker");
  static Function(List<List<double>>)? onNewFrame;

  static void startCamera() async {
    await channel.invokeMethod("startCamera");

    channel.setMethodCallHandler((call) async {
      if (call.method == "newFrame") {
        List data = call.arguments;
        List<List<double>> landmarks = List<List<double>>.from(
          data.map((e) => List<double>.from(e))
        );
        if (onNewFrame != null) onNewFrame!(landmarks);
      }
    });
  }
}