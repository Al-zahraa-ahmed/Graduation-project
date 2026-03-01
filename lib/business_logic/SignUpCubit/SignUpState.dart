part of 'SignUpCubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final int userid;

  SignUpSuccess({required this.userid});
}

final class SignUpFailure extends SignUpState {
  final String errormsg;

  SignUpFailure({required this.errormsg});
}
