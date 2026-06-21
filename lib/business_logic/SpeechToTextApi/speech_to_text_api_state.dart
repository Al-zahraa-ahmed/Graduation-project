part of 'speech_to_text_api_cubit.dart';

@immutable
sealed class SpeechToTextApiState {}

class SpeechToTextApiInitial extends SpeechToTextApiState {}

class SpeechToTextApiLoading extends SpeechToTextApiState {}

class SpeechToTextApiSuccess extends SpeechToTextApiState {
  final SpeechToTextResultModel result;
  SpeechToTextApiSuccess({required this.result});
}

class SpeechToTextApiFailure extends SpeechToTextApiState {
  final String errmsg;
  SpeechToTextApiFailure({required this.errmsg});
}
