import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

class HandLandmark {
  final double x;
  final double y;
  final double z;
  const HandLandmark(this.x, this.y, this.z);

  factory HandLandmark.fromMap(Map<dynamic, dynamic> m) => HandLandmark(
        (m['x'] as num).toDouble(),
        (m['y'] as num).toDouble(),
        (m['z'] as num).toDouble(),
      );
}

class DetectedHand {
  /// 21 normalized hand landmarks from MediaPipe.
  final List<HandLandmark> landmarks;

  /// "Left" or "Right" — MediaPipe's reported handedness (assumes selfie/mirrored input).
  final String handedness;

  const DetectedHand({required this.landmarks, required this.handedness});

  factory DetectedHand.fromMap(Map<dynamic, dynamic> m) {
    final list = (m['landmarks'] as List)
        .map((e) => HandLandmark.fromMap(e as Map))
        .toList(growable: false);
    return DetectedHand(
      landmarks: list,
      handedness: m['handedness'] as String? ?? 'Unknown',
    );
  }
}

/// Singleton wrapper around the native MediaPipe HandLandmarker (Android only).
/// Mirrors the Python pipeline exactly: VIDEO mode, 2 hands, 0.3 confidences,
/// optional horizontal mirror to match `cv2.flip(frame, 1)`.
class MediapipeHandService {
  static const _channel = MethodChannel('signlingo/hand_landmarker');
  static MediapipeHandService? _instance;

  MediapipeHandService._();
  static MediapipeHandService get instance =>
      _instance ??= MediapipeHandService._();

  bool _initialized = false;
  bool get isInitialized => _initialized;

  /// Loads `Assets/models/hand_landmarker.task` and hands the raw bytes to the
  /// native side, which keeps a direct ByteBuffer alive for MediaPipe.
  Future<void> initialize() async {
    if (_initialized) return;
    final raw = await rootBundle.load('Assets/models/hand_landmarker.task');
    final bytes = raw.buffer.asUint8List(raw.offsetInBytes, raw.lengthInBytes);
    await _channel.invokeMethod('initialize', {'modelBytes': bytes});
    _initialized = true;
  }

  /// Run detection on a single camera frame.
  ///
  /// [rotationDegrees] is typically `controller.description.sensorOrientation`
  /// — applied to bring the sensor image upright before MediaPipe sees it.
  /// [mirror] flips the image horizontally (set true for front camera to match
  /// the Python pipeline's `cv2.flip`).
  /// [timestampMs] must increase monotonically (VIDEO running mode).
  Future<List<DetectedHand>> detect({
    required CameraImage image,
    required int rotationDegrees,
    required bool mirror,
    required int timestampMs,
  }) async {
    if (!_initialized) {
      throw StateError('MediapipeHandService.initialize() must be called first');
    }
    if (image.planes.length < 3) {
      throw ArgumentError('Expected YUV_420_888 image with 3 planes, '
          'got ${image.planes.length}');
    }

    final result = await _channel.invokeMethod<List<dynamic>>('detect', {
      'y': image.planes[0].bytes,
      'u': image.planes[1].bytes,
      'v': image.planes[2].bytes,
      'width': image.width,
      'height': image.height,
      'yRowStride': image.planes[0].bytesPerRow,
      'uvRowStride': image.planes[1].bytesPerRow,
      'uvPixelStride': image.planes[1].bytesPerPixel ?? 1,
      'rotationDegrees': rotationDegrees,
      'mirror': mirror,
      'timestampMs': timestampMs,
    });

    if (result == null || result.isEmpty) return const [];
    return result
        .map((e) => DetectedHand.fromMap(e as Map))
        .toList(growable: false);
  }

  Future<void> dispose() async {
    if (!_initialized) return;
    try {
      await _channel.invokeMethod('dispose');
    } catch (_) {
      // best-effort cleanup
    }
    _initialized = false;
  }
}
