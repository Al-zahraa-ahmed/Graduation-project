part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSucces extends ProfileState {
  final UserModel user;

  ProfileSucces({required this.user});
}

final class ChangeLangSuccess extends ProfileState {}

final class ChangeLangFailure extends ProfileState {
  final String errmsg;
  ChangeLangFailure({required this.errmsg});
}

final class ChangeModeSuccess extends ProfileState {}

final class ChangeModeFailure extends ProfileState {
  final String errrmsg;

  ChangeModeFailure({required this.errrmsg});
}

final class ProfileFailure extends ProfileState {
  final String errmsg;

  ProfileFailure({required this.errmsg});
}
