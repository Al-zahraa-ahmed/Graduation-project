import 'package:flutter/services.dart';

class TestMediapipe {

  static const channel = MethodChannel("mediapipe_channel");

  static Future<String> test() async {

    final result = await channel.invokeMethod("test");

    return result;
  }

}