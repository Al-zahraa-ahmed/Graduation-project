part of 'voice_translation_cubit.dart';

enum VoiceErrorType { permissionDenied, unavailable, noSpeech, unknown }

@immutable
sealed class VoiceTranslationState {}

final class VoiceTranslationInitial extends VoiceTranslationState {}

final class VoiceTranslationInitializing extends VoiceTranslationState {}

final class VoiceTranslationReady extends VoiceTranslationState {
  final String text;
  VoiceTranslationReady({required this.text});
}

final class VoiceTranslationListening extends VoiceTranslationState {
  final String partial;
  final String accumulated;
  VoiceTranslationListening({required this.partial, required this.accumulated});

  String get displayText {
    if (partial.isEmpty) return accumulated;
    if (accumulated.isEmpty) return partial;
    return '$accumulated $partial';
  }
}

final class VoiceTranslationFailure extends VoiceTranslationState {
  final VoiceErrorType type;
  final String message;
  VoiceTranslationFailure({required this.type, required this.message});
}
