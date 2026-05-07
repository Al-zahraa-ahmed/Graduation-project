import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:graduation_project/data/Models/labels_map.dart';
import 'package:onnxruntime/onnxruntime.dart';

class SignPrediction {
  final String label;
  final double confidence;
  const SignPrediction({required this.label, required this.confidence});
}

/// 1:1 port of the Python sign-language inference pipeline:
///   normalize_landmarks → resample_sequence → ONNX run → softmax → argmax
/// with MIN_CONFIDENCE = 50.0 and the "غير معروف" fallback label.
class SignLanguageClassifier {
  static SignLanguageClassifier? _instance;
  OrtSession? _session;
  bool _initialized = false;

  SignLanguageClassifier._();
  static SignLanguageClassifier get instance =>
      _instance ??= SignLanguageClassifier._();

  bool get isInitialized => _initialized;

  // Python: TARGET_FRAMES = 30, FEATURES = 126, MIN_CONFIDENCE = 50.0
  static const int _targetFrames = 30;
  static const int _features = 126;
  static const double _minConfidence = 50.0;
  static const String _unknownLabel = 'غير معروف';

  Future<void> initialize() async {
    if (_initialized) return;
    OrtEnv.instance.init();
    final raw = await rootBundle.load(
      'Assets/models/sign_lstm_attention_fp32.onnx',
    );
    _session = OrtSession.fromBuffer(
      raw.buffer.asUint8List(),
      OrtSessionOptions(),
    );
    _initialized = true;
  }

  /// Returns null only when the model isn't loaded or the sequence is empty.
  /// All other cases produce a prediction; below-threshold results carry the
  /// "غير معروف" label, mirroring Python's behaviour.
  SignPrediction? predict(List<List<double>> frames) {
    if (!_initialized || _session == null) return null;
    if (frames.isEmpty) return null;

    // 1. Per-frame normalize (Python: normalize_landmarks)
    final normalized = frames
        .map(_normalizeLandmarks)
        .toList(growable: false);

    // 2. Resample to 30 frames (Python: resample_sequence with linear interp1d)
    final resampled = _resampleSequence(normalized, _targetFrames);

    // 3. Build [1, 30, 126] tensor
    final flat = Float32List(_targetFrames * _features);
    var k = 0;
    for (final frame in resampled) {
      for (var i = 0; i < _features; i++) {
        flat[k++] = frame[i];
      }
    }

    final input = OrtValueTensor.createTensorWithDataList(
      flat,
      [1, _targetFrames, _features],
    );
    final runOptions = OrtRunOptions();
    final inputName = _session!.inputNames.first;

    List<OrtValue?>? outputs;
    try {
      outputs = _session!.run(runOptions, {inputName: input});

      // Python: logits = session.run(["logits"], ...)[0]; probs = softmax(logits[0])
      final outTensor = outputs.first;
      final batched = (outTensor?.value as List).cast<List>();
      final logits = batched.first.cast<double>();

      final probs = _softmax(logits);

      // Python: pred_idx = int(np.argmax(probs)); confidence = probs[pred_idx] * 100
      var bestIdx = 0;
      var bestProb = probs[0];
      for (var i = 1; i < probs.length; i++) {
        if (probs[i] > bestProb) {
          bestProb = probs[i];
          bestIdx = i;
        }
      }
      final confidence = bestProb * 100;

      // Python: if pred_idx in labels_map and confidence >= MIN_CONFIDENCE: use label
      //         else: prediction = "غير معروف"
      final label = (labelsMap.containsKey(bestIdx) && confidence >= _minConfidence)
          ? labelsMap[bestIdx]!
          : _unknownLabel;

      return SignPrediction(label: label, confidence: confidence);
    } finally {
      input.release();
      runOptions.release();
      if (outputs != null) {
        for (final o in outputs) {
          o?.release();
        }
      }
    }
  }

  /// Python:
  ///   lh = frame[:63].reshape(21, 3); rh = frame[63:].reshape(21, 3)
  ///   if any(lh != 0): lh = (lh - wrist) / (max(|lh|) + 1e-6)
  ///   (same for rh); return concatenate([lh.flatten(), rh.flatten()])
  List<double> _normalizeLandmarks(List<double> frame) {
    final out = List<double>.from(frame);
    _normalizeHand(out, 0);
    _normalizeHand(out, 63);
    return out;
  }

  void _normalizeHand(List<double> data, int offset) {
    var any = false;
    for (var i = 0; i < 63; i++) {
      if (data[offset + i] != 0.0) {
        any = true;
        break;
      }
    }
    if (!any) return;

    // Subtract wrist (landmark 0 → first 3 values).
    final wx = data[offset];
    final wy = data[offset + 1];
    final wz = data[offset + 2];
    for (var i = 0; i < 21; i++) {
      data[offset + i * 3] -= wx;
      data[offset + i * 3 + 1] -= wy;
      data[offset + i * 3 + 2] -= wz;
    }

    // Divide by max absolute value across all 63 entries (Python's np.max(np.abs(lh))).
    var maxAbs = 0.0;
    for (var i = 0; i < 63; i++) {
      final a = data[offset + i].abs();
      if (a > maxAbs) maxAbs = a;
    }
    final scale = maxAbs + 1e-6;
    for (var i = 0; i < 63; i++) {
      data[offset + i] /= scale;
    }
  }

  /// Python: linear interp1d over linspace(0,1,n) → linspace(0,1,target).
  /// Equivalent to interpolating at fractional indices in [0, n-1].
  List<List<double>> _resampleSequence(
    List<List<double>> seq,
    int targetFrames,
  ) {
    final n = seq.length;
    if (n == targetFrames) return seq;

    final out = List.generate(
      targetFrames,
      (_) => List<double>.filled(_features, 0),
    );
    if (n == 1) {
      for (var t = 0; t < targetFrames; t++) {
        for (var f = 0; f < _features; f++) {
          out[t][f] = seq[0][f];
        }
      }
      return out;
    }

    for (var t = 0; t < targetFrames; t++) {
      final pos = (t * (n - 1)) / (targetFrames - 1);
      final lo = pos.floor();
      final hi = pos.ceil();
      if (lo == hi || hi >= n) {
        final idx = lo.clamp(0, n - 1);
        for (var f = 0; f < _features; f++) {
          out[t][f] = seq[idx][f];
        }
      } else {
        final frac = pos - lo;
        final a = seq[lo];
        final b = seq[hi];
        for (var f = 0; f < _features; f++) {
          out[t][f] = a[f] * (1 - frac) + b[f] * frac;
        }
      }
    }
    return out;
  }

  /// Python: e = exp(x - max(x)); return e / e.sum()
  List<double> _softmax(List<double> logits) {
    var m = logits[0];
    for (var i = 1; i < logits.length; i++) {
      if (logits[i] > m) m = logits[i];
    }
    final exps = List<double>.filled(logits.length, 0);
    var sum = 0.0;
    for (var i = 0; i < logits.length; i++) {
      final e = exp(logits[i] - m);
      exps[i] = e;
      sum += e;
    }
    for (var i = 0; i < logits.length; i++) {
      exps[i] /= sum;
    }
    return exps;
  }

  void dispose() {
    _session?.release();
    OrtEnv.instance.release();
    _session = null;
    _initialized = false;
    _instance = null;
  }
}
