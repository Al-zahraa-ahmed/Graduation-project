part of 'send_frames_cubit.dart';

@immutable
sealed class SendFramesState {}

final class SendFramesInitial extends SendFramesState {}

final class SendFramesSucess extends SendFramesState {
  
}

final class SendFramesFailure extends SendFramesState {
  final String errmsg;

  SendFramesFailure({required this.errmsg});
}
