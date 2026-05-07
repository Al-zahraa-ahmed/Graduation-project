package com.example.graduation_project

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "signlingo/hand_landmarker"
    private var service: HandLandmarkerService? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "initialize" -> {
                        val bytes = call.argument<ByteArray>("modelBytes")
                        if (bytes == null) {
                            result.error("BAD_ARGS", "modelBytes required", null)
                            return@setMethodCallHandler
                        }
                        try {
                            service?.close()
                            service = HandLandmarkerService(applicationContext, bytes)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("INIT_FAILED", e.message, null)
                        }
                    }

                    "detect" -> {
                        val svc = service
                        if (svc == null) {
                            result.error("NOT_INITIALIZED", "Call initialize first", null)
                            return@setMethodCallHandler
                        }
                        try {
                            val hands = svc.detect(
                                yBytes = call.argument<ByteArray>("y")!!,
                                uBytes = call.argument<ByteArray>("u")!!,
                                vBytes = call.argument<ByteArray>("v")!!,
                                width = call.argument<Int>("width")!!,
                                height = call.argument<Int>("height")!!,
                                yRowStride = call.argument<Int>("yRowStride")!!,
                                uvRowStride = call.argument<Int>("uvRowStride")!!,
                                uvPixelStride = call.argument<Int>("uvPixelStride")!!,
                                rotationDegrees = call.argument<Int>("rotationDegrees")!!,
                                mirror = call.argument<Boolean>("mirror") ?: false,
                                timestampMs = (call.argument<Number>("timestampMs")!!).toLong()
                            )
                            result.success(hands)
                        } catch (e: Exception) {
                            result.error("DETECT_FAILED", e.message, null)
                        }
                    }

                    "dispose" -> {
                        service?.close()
                        service = null
                        result.success(true)
                    }

                    else -> result.notImplemented()
                }
            }
    }

    override fun onDestroy() {
        service?.close()
        service = null
        super.onDestroy()
    }
}
