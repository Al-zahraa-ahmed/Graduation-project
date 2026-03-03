part of 'verify_forget_pass_cubit.dart';

@immutable
sealed class VerifyForgetPassState {}

final class VerifyForgetPassInitial extends VerifyForgetPassState {}

final class VerifyForgetPassLoading extends VerifyForgetPassState {}

final class VerifyForgetPassSuccess extends VerifyForgetPassState {
  final String resetToken;

  VerifyForgetPassSuccess({required this.resetToken});
}

final class VerifyForgetPassFailure extends VerifyForgetPassState {
  final String errmsg;

  VerifyForgetPassFailure({required this.errmsg});
}
