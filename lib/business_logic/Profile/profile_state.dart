part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSucces extends ProfileState {
  final ProfileModel user;

  ProfileSucces({required this.user});
}

final class ProfileFailure extends ProfileState {
  final String errmsg;

  ProfileFailure({required this.errmsg});
}
