part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSucces extends ProfileState {
  final ProfileModel user;

  ProfileSucces({required this.user});
}

/// Emitted when a pref update (changeLang / changeMode) failed and the
/// optimistic state has been rolled back to [user]. UI should keep showing
/// [user] (preserves profile data) and surface [errmsg] via a snackbar.
final class ProfilePrefUpdateFailed extends ProfileState {
  final ProfileModel user;
  final String errmsg;

  ProfilePrefUpdateFailed({required this.user, required this.errmsg});
}

final class ProfileFailure extends ProfileState {
  final String errmsg;

  ProfileFailure({required this.errmsg});
}
