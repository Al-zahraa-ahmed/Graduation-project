import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:graduation_project/data/Models/ProfileModel.dart';
import 'package:graduation_project/data/Services/UserApiService.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final UserApiService userApi = UserApiService();

  /// Returns the currently-loaded user from state, regardless of which
  /// success-shaped state we're in. Returns null if profile hasn't loaded yet.
  ProfileModel? get _currentUser {
    final s = state;
    if (s is ProfileSucces) return s.user;
    if (s is ProfilePrefUpdateFailed) return s.user;
    return null;
  }

  Future<void> getMainData() async {
    if (isClosed) return;
    emit(ProfileLoading());
    try {
      final response = await userApi.getUserMainData();
      if (isClosed) return;
      emit(ProfileSucces(user: response));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: ApiException.fromDio(e).message));
    } catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: e.toString()));
    }
  }

  /// Optimistically updates the language and persists to server + cache.
  /// Returns true on success, false on failure (state is rolled back to the
  /// previous user and a [ProfilePrefUpdateFailed] is emitted).
  Future<bool> changelang({required String lang}) async {
    final prevUser = _currentUser;
    if (prevUser == null) return false;
    if (prevUser.language == lang) return true; // no-op

    // Optimistic update so UI reflects the change immediately.
    emit(ProfileSucces(user: prevUser.copyWith(language: lang)));
    try {
      await userApi.changeLanguage(language: lang);
      await CacheHelper.saveData(key: 'lang', value: lang);
      return true;
    } on DioException catch (e) {
      if (isClosed) return false;
      emit(ProfilePrefUpdateFailed(
        user: prevUser,
        errmsg: ApiException.fromDio(e).message,
      ));
      return false;
    } catch (_) {
      if (isClosed) return false;
      emit(ProfilePrefUpdateFailed(
        user: prevUser,
        errmsg: 'Something went wrong. Please try again.',
      ));
      return false;
    }
  }

  /// Optimistically updates the mode and persists to server + cache.
  /// Returns true on success, false on failure (state rolled back).
  Future<bool> changeMode({required String mode}) async {
    final prevUser = _currentUser;
    if (prevUser == null) return false;
    if (prevUser.mode == mode) return true; // no-op

    emit(ProfileSucces(user: prevUser.copyWith(mode: mode)));
    try {
      await userApi.changeMode(mode: mode);
      await CacheHelper.saveData(key: 'mode', value: mode);
      return true;
    } on DioException catch (e) {
      if (isClosed) return false;
      emit(ProfilePrefUpdateFailed(
        user: prevUser,
        errmsg: ApiException.fromDio(e).message,
      ));
      return false;
    } catch (_) {
      if (isClosed) return false;
      emit(ProfilePrefUpdateFailed(
        user: prevUser,
        errmsg: 'Something went wrong. Please try again.',
      ));
      return false;
    }
  }

  Future<void> deleteAccount() async {
    await userApi.deleteAccount();
  }
}
