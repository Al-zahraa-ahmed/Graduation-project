part of 'profile_information_cubit.dart';

@immutable
sealed class ProfileInformationState {
  const ProfileInformationState();
}

class ProfileInformationInitial extends ProfileInformationState {
  const ProfileInformationInitial();
}

class ProfileInformationLoading extends ProfileInformationState {
  const ProfileInformationLoading();
}

class ProfileInformationLoaded extends ProfileInformationState {
  final UserModel user;
  const ProfileInformationLoaded({required this.user});
}

class ProfileInformationLoadError extends ProfileInformationState {
  final String message;
  const ProfileInformationLoadError({required this.message});
}

class ProfileInformationSaving extends ProfileInformationState {
  final UserModel user;
  const ProfileInformationSaving({required this.user});
}

class ProfileInformationSaveSuccess extends ProfileInformationState {
  final UserModel user;
  const ProfileInformationSaveSuccess({required this.user});
}

class ProfileInformationSaveError extends ProfileInformationState {
  final UserModel user;
  final String message;
  const ProfileInformationSaveError({
    required this.user,
    required this.message,
  });
}
