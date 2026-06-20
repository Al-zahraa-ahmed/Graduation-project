part of 'google_auth_cubit.dart';

@immutable
sealed class GoogleAuthState {}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthSuccess extends GoogleAuthState {
  final String token;
  GoogleAuthSuccess({required this.token});
}

class GoogleAuthFailure extends GoogleAuthState {
  final String message;
  GoogleAuthFailure({required this.message});
}
