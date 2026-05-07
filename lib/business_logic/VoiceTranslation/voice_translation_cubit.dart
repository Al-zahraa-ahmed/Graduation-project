import 'package:bloc/bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'voice_translation_state.dart';

class VoiceTranslationCubit extends Cubit<VoiceTranslationState> {
  VoiceTranslationCubit() : super(VoiceTranslationInitial());

  final SpeechToText _speech = SpeechToText();
  bool _serviceReady = false;
  String _accumulated = '';

  Future<void> initialize() async {
    if (isClosed) return;
    emit(VoiceTranslationInitializing());
    try {
      _serviceReady = await _speech.initialize(
        onStatus: _handleStatus,
        onError: _handleError,
      );
      if (isClosed) return;
      if (_serviceReady) {
        emit(VoiceTranslationReady(text: _accumulated));
      } else {
        emit(VoiceTranslationFailure(
          type: VoiceErrorType.unavailable,
          message: 'Speech recognition not available',
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(VoiceTranslationFailure(
        type: VoiceErrorType.unknown,
        message: e.toString(),
      ));
    }
  }

  Future<void> startListening() async {
    if (isClosed || !_serviceReady || _speech.isListening) return;

    emit(VoiceTranslationListening(partial: '', accumulated: _accumulated));

    try {
      final localeId = await _resolveLocaleId();
      await _speech.listen(
        localeId: localeId,
        onResult: _handleResult,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        listenOptions: SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
          listenMode: ListenMode.dictation,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(VoiceTranslationFailure(
        type: VoiceErrorType.unknown,
        message: e.toString(),
      ));
    }
  }

  Future<void> stopListening() async {
    if (isClosed) return;
    if (_speech.isListening) {
      await _speech.stop();
    }
    if (isClosed) return;
    emit(VoiceTranslationReady(text: _accumulated));
  }

  void clear() {
    if (isClosed) return;
    _accumulated = '';
    emit(VoiceTranslationReady(text: ''));
  }

  /// Resolve locale from app cache. Falls back to device default if the
  /// preferred locale isn't installed on the speech engine.
  Future<String?> _resolveLocaleId() async {
    final lang = CacheHelper.getData('lang') as String? ?? 'en';
    final preferred = lang == 'ar' ? 'ar-SA' : 'en-US';
    try {
      final locales = await _speech.locales();
      final prefix = preferred.split('-').first;
      final hit = locales.firstWhere(
        (l) => l.localeId.startsWith(prefix),
        orElse: () => locales.firstWhere(
          (l) => l.localeId.startsWith(preferred),
          orElse: () => locales.first,
        ),
      );
      return hit.localeId;
    } catch (_) {
      return preferred;
    }
  }

  void _handleResult(SpeechRecognitionResult result) {
    if (isClosed) return;
    final words = result.recognizedWords;

    if (result.finalResult) {
      _accumulated = _accumulated.isEmpty ? words : '$_accumulated $words';
      emit(VoiceTranslationReady(text: _accumulated));
    } else {
      emit(VoiceTranslationListening(
        partial: words,
        accumulated: _accumulated,
      ));
    }
  }

  void _handleStatus(String status) {
    if (isClosed) return;
    if ((status == 'notListening' || status == 'done') &&
        state is VoiceTranslationListening) {
      emit(VoiceTranslationReady(text: _accumulated));
    }
  }

  void _handleError(SpeechRecognitionError error) {
    if (isClosed) return;
    final msg = error.errorMsg.toLowerCase();
    final type = msg.contains('permission') || msg.contains('denied')
        ? VoiceErrorType.permissionDenied
        : msg.contains('no_match') || msg.contains('no match')
            ? VoiceErrorType.noSpeech
            : VoiceErrorType.unknown;
    emit(VoiceTranslationFailure(type: type, message: error.errorMsg));
  }

  @override
  Future<void> close() async {
    if (_speech.isListening) {
      await _speech.stop();
    }
    return super.close();
  }
}
