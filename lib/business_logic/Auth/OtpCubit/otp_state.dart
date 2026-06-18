part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

/// Emitted after a successful signup OTP verification.
/// `token` is a long-lived JWT auth token to cache and use as Bearer.
final class OtpVerifySuccess extends OtpState {
  final String token;
  final UserModel user;

  OtpVerifySuccess({required this.token, required this.user});
}

/// Emitted after a successful forgot-password OTP verification.
/// `resetToken` is a one-time token only valid for /reset-password.
final class OtpForgetVerifySuccess extends OtpState {
  final String resetToken;

  OtpForgetVerifySuccess({required this.resetToken});
}

final class OtpResentSuccess extends OtpState {}

final class OtpFailure extends OtpState {
  final String errmsg;

  OtpFailure({required this.errmsg});
}
