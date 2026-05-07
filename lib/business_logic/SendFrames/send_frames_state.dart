part of 'send_frames_cubit.dart';

@immutable
sealed class SignPredictionState {}

final class SignPredictionInitial extends SignPredictionState {}

final class SignPredictionLoading extends SignPredictionState {}

final class SignPredictionSuccess extends SignPredictionState {
  final String label;
  final double confidence;

  SignPredictionSuccess({required this.label, required this.confidence});
}

final class SignPredictionFailure extends SignPredictionState {
  final String errmsg;

  SignPredictionFailure({required this.errmsg});
}
