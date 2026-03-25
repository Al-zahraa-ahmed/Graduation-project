import 'package:flutter/services.dart';

class MediapipeService {

  static const platform = MethodChannel('mediapipe_channel');

  static Future<List<double>> detectHands(Uint8List imageBytes) async {

    final result = await platform.invokeMethod(
      "detectHands",
      {
        "image": imageBytes
      },
    );

    return List<double>.from(result);
  }

}