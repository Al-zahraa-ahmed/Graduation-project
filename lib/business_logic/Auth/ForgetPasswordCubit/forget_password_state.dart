part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final int userId;

  ForgetPasswordSuccess({required this.userId});
}

final class ForgetPasswordFailure extends ForgetPasswordState {
  final String errmsg;

  ForgetPasswordFailure({required this.errmsg});
}
