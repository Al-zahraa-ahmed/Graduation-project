import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/data/Services/UserApiService.dart';

part 'profile_information_state.dart';

/// Backs the Profile Information screen: loads the current user from
/// `/user/all-data` on creation and persists edits via `update-data`.
/// Surfaces ApiException messages on failure so the UI can show friendly text.
class ProfileInformationCubit extends Cubit<ProfileInformationState> {
  ProfileInformationCubit() : super(const ProfileInformationInitial()) {
    loadUser();
  }

  final UserApiService _userApi = UserApiService();

  Future<void> loadUser() async {
    if (isClosed) return;
    emit(const ProfileInformationLoading());
    try {
      final user = await _userApi.getUserAllData();
      if (isClosed) return;
      emit(ProfileInformationLoaded(user: user));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ProfileInformationLoadError(
        message: ApiException.fromDio(e).message,
      ));
    } catch (_) {
      if (isClosed) return;
      emit(const ProfileInformationLoadError(
        message: 'Failed to load profile. Please try again.',
      ));
    }
  }

  Future<void> updateUser({
    required String username,
    required String email,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    String? imgPath,
    bool removeImage = false,
  }) async {
    if (isClosed) return;
    final UserModel? currentUser = switch (state) {
      ProfileInformationLoaded(:final user) => user,
      ProfileInformationSaveError(:final user) => user,
      _ => null,
    };
    if (currentUser == null) return;

    emit(ProfileInformationSaving(user: currentUser));
    try {
      // The backend still expects `name`; we no longer surface a separate
      // field in the UI, so reuse `username` for it.
      await _userApi.updateUserData(
        username: username,
        name: username,
        email: email,
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
        imgPath: imgPath,
        removeImage: removeImage,
      );
      if (isClosed) return;
      emit(ProfileInformationSaveSuccess(user: currentUser));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ProfileInformationSaveError(
        user: currentUser,
        message: ApiException.fromDio(e).message,
      ));
    } catch (_) {
      if (isClosed) return;
      emit(ProfileInformationSaveError(
        user: currentUser,
        message: 'Something went wrong. Please try again.',
      ));
    }
  }
}
