import 'package:bloc/bloc.dart';
import 'package:graduation_project/data/Models/SpeechToTextResultModel.dart';
import 'package:graduation_project/data/Services/SpeechToTextApiService.dart';
import 'package:meta/meta.dart';

part 'speech_to_text_api_state.dart';

/// Drives the backend speech-to-text flow (upload audio file -> transcription).
///
/// Standalone integration for the server-side STT model. The live app uses the
/// on-device `speech_to_text` package instead, so this cubit is NOT wired into
/// any screen — it exists as the server-side STT integration.
class SpeechToTextApiCubit extends Cubit<SpeechToTextApiState> {
  SpeechToTextApiCubit() : super(SpeechToTextApiInitial());

  final SpeechToTextApiService _service = SpeechToTextApiService();

  /// Sends [audioFilePath] to the backend and emits the transcription.
  Future<void> transcribe(String audioFilePath) async {
    if (isClosed) return;
    emit(SpeechToTextApiLoading());
    try {
      final result = await _service.transcribe(audioFilePath);
      if (isClosed) return;
      emit(SpeechToTextApiSuccess(result: result));
    } catch (e) {
      if (isClosed) return;
      emit(SpeechToTextApiFailure(errmsg: e.toString()));
    }
  }
}
