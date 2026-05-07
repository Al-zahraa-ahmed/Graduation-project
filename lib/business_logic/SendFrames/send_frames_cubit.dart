import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:graduation_project/data/Services/sign_language_classifier.dart';

part 'send_frames_state.dart';

class SignPredictionCubit extends Cubit<SignPredictionState> {
  SignPredictionCubit() : super(SignPredictionInitial());

  final _classifier = SignLanguageClassifier.instance;

  Future<void> initModel() async {
    try {
      await _classifier.initialize();
    } catch (e) {
      emit(SignPredictionFailure(errmsg: 'Failed to load model: $e'));
    }
  }

  void predictSign(List<List<double>> frames) {
    if (isClosed) return;
    emit(SignPredictionLoading());

    try {
      final result = _classifier.predict(frames);
      if (isClosed) return;

      if (result != null) {
        emit(SignPredictionSuccess(
          label: result.label,
          confidence: result.confidence,
        ));
      } else {
        emit(SignPredictionInitial());
      }
    } catch (e) {
      if (isClosed) return;
      emit(SignPredictionFailure(errmsg: 'Prediction error: $e'));
    }
  }

  void reset() {
    if (isClosed) return;
    emit(SignPredictionInitial());
  }
}
