import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/SendFrames/send_frames_cubit.dart';
import 'package:graduation_project/data/Services/mediapipe_hand_service.dart';
import 'package:graduation_project/generated/l10n.dart';

/// Real-time sign-language inference view.
///
/// Pipeline mirrors `final.py`:
///   front camera → mirror (cv2.flip) → MediaPipe HandLandmarker (VIDEO mode) →
///   per-frame [126]-vector keyed by MediaPipe handedness ("Left"/"Right") →
///   on first empty frame after ≥10 collected → predict.
class HandTrackerView extends StatefulWidget {
  const HandTrackerView({super.key});

  @override
  State<HandTrackerView> createState() => _HandTrackerViewState();
}

class _HandTrackerViewState extends State<HandTrackerView> {
  CameraController? _controller;
  final _detector = MediapipeHandService.instance;

  bool _isInitialized = false;
  bool _isProcessing = false;
  bool _disposed = false;

  /// Python: `timestamp_ms += 33` per frame (VIDEO mode requires monotonic ts).
  int _timestampMs = 0;

  /// Python: `sequence` — list of per-frame [126] vectors.
  final List<List<double>> _sequence = [];

  /// Python: `hands_were_detected` — true after at least one frame had hands.
  bool _handsWereDetected = false;

  /// Python: `if hands_were_detected and len(sequence) > 10` → predict.
  static const int _minFramesForPrediction = 10;

  /// Latest hand count, just for UI overlay.
  int _latestHandCount = 0;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (!_detector.isInitialized) {
      await _detector.initialize();
    }
    if (_disposed) return;

    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await _controller!.initialize();
    if (_disposed) return;

    await _controller!.startImageStream(_onCameraImage);
    if (mounted) setState(() => _isInitialized = true);
  }

  Future<void> _onCameraImage(CameraImage image) async {
    if (_isProcessing || !_isInitialized || _disposed) return;
    _isProcessing = true;

    // VIDEO mode requires monotonically increasing timestamps.
    _timestampMs += 33;

    try {
      final controller = _controller!;
      final isFront =
          controller.description.lensDirection == CameraLensDirection.front;

      final hands = await _detector.detect(
        image: image,
        rotationDegrees: controller.description.sensorOrientation,
        mirror: isFront, // matches `cv2.flip(frame, 1)`
        timestampMs: _timestampMs,
      );

      if (_disposed) return;

      final detected = hands.isNotEmpty;

      if (detected) {
        _sequence.add(_buildFrameVector(hands));
        _handsWereDetected = true;
      } else {
        // Python: as soon as a frame has no hands AND we'd previously seen
        // hands AND collected >10 frames → predict. Otherwise discard.
        if (_handsWereDetected) {
          if (_sequence.length > _minFramesForPrediction) {
            _triggerPrediction();
          } else {
            _sequence.clear();
          }
          _handsWereDetected = false;
        }
      }

      if (mounted) setState(() => _latestHandCount = hands.length);
    } catch (e) {
      debugPrint('Hand detection error: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Build a 126-element vector with handedness-correct slot assignment:
  ///   - landmarks 0..62  : user's LEFT hand (handedness == "Left")
  ///   - landmarks 63..125: user's RIGHT hand (handedness == "Right")
  /// Mirrors Python: `if handedness == "Left": lh = coords; else: rh = coords`.
  List<double> _buildFrameVector(List<DetectedHand> hands) {
    final lh = List<double>.filled(63, 0.0);
    final rh = List<double>.filled(63, 0.0);

    for (final hand in hands) {
      final coords = List<double>.filled(63, 0.0);
      var k = 0;
      for (final lm in hand.landmarks) {
        if (k + 2 >= 63) break;
        coords[k++] = lm.x;
        coords[k++] = lm.y;
        coords[k++] = lm.z;
      }
      if (hand.handedness == 'Left') {
        for (var i = 0; i < 63; i++) {
          lh[i] = coords[i];
        }
      } else {
        // "Right" or "Unknown" → right slot (matches Python `else: rh = coords`)
        for (var i = 0; i < 63; i++) {
          rh[i] = coords[i];
        }
      }
    }

    return [...lh, ...rh];
  }

  void _triggerPrediction() {
    final frames = List<List<double>>.from(_sequence);
    _sequence.clear();
    context.read<SignPredictionCubit>().predictSign(frames);
  }

  void _resetPrediction() {
    _sequence.clear();
    _handsWereDetected = false;
    context.read<SignPredictionCubit>().reset();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.stopImageStream();
    _controller?.dispose();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
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
      appBar: AppBar(title: Text(S.of(context).live_tracking)),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: previewAspectRatio,
                child: Stack(
                  children: [
                    CameraPreview(controller),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: _StatusChip(
                        active: _latestHandCount > 0,
                        text: _latestHandCount > 0
                            ? '${_sequence.length} frames'
                            : S.of(context).live_tracking,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<SignPredictionCubit, SignPredictionState>(
            builder: (context, state) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (state is SignPredictionLoading)
                      const CircularProgressIndicator()
                    else if (state is SignPredictionSuccess) ...[
                      Text(
                        state.label,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${state.confidence.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 18,
                          color: state.confidence > 70
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ] else if (state is SignPredictionFailure)
                      Text(
                        state.errmsg,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14),
                      )
                    else
                      Text(
                        S.of(context).live_tracking,
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: _resetPrediction,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.active, required this.text});
  final bool active;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (active ? Colors.green : Colors.red).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            active ? Icons.back_hand : Icons.back_hand_outlined,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
