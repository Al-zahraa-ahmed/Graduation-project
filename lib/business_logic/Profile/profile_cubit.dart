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
      // First-login sync: if the device has no cached locale/mode yet, adopt
      // the server's values so a fresh device matches the account's prefs.
      // Once cached, the local choice wins and is only updated via
      // [changelang]/[changeMode].
      if (CacheHelper.getData('lang') == null &&
          response.language != null &&
          response.language!.isNotEmpty) {
        await CacheHelper.saveData(key: 'lang', value: response.language!);
      }
      if (CacheHelper.getData('mode') == null &&
          response.mode != null &&
          response.mode!.isNotEmpty) {
        await CacheHelper.saveData(key: 'mode', value: response.mode!);
      }
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
  ///
  /// Cache is written BEFORE emitting so the MaterialApp's BlocBuilder reads
  /// the new locale on the same frame (main.dart trusts the cache, not state).
  Future<bool> changelang({required String lang}) async {
    final prevUser = _currentUser;
    if (prevUser == null) return false;
    if (prevUser.language == lang) return true; // no-op

    await CacheHelper.saveData(key: 'lang', value: lang);
    emit(ProfileSucces(user: prevUser.copyWith(language: lang)));
    try {
      await userApi.changeLanguage(language: lang);
      return true;
    } on DioException catch (e) {
      if (isClosed) return false;
      await _rollbackCache(key: 'lang', value: prevUser.language);
      emit(ProfilePrefUpdateFailed(
        user: prevUser,
        errmsg: ApiException.fromDio(e).message,
      ));
      return false;
    } catch (_) {
      if (isClosed) return false;
      await _rollbackCache(key: 'lang', value: prevUser.language);
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

    await CacheHelper.saveData(key: 'mode', value: mode);
    emit(ProfileSucces(user: prevUser.copyWith(mode: mode)));
    try {
      await userApi.changeMode(mode: mode);
      return true;
    } on DioException catch (e) {
      if (isClosed) return false;
      await _rollbackCache(key: 'mode', value: prevUser.mode);
      emit(ProfilePrefUpdateFailed(
        user: prevUser,
        errmsg: ApiException.fromDio(e).message,
      ));
      return false;
    } catch (_) {
      if (isClosed) return false;
      await _rollbackCache(key: 'mode', value: prevUser.mode);
      emit(ProfilePrefUpdateFailed(
        user: prevUser,
        errmsg: 'Something went wrong. Please try again.',
      ));
      return false;
    }
  }

  /// Restores a cache key to the previous user's value after a failed
  /// optimistic update. If the previous value was null, removes the key so
  /// the default kicks in on the next read.
  Future<void> _rollbackCache({required String key, String? value}) async {
    if (value == null || value.isEmpty) {
      await CacheHelper.removeData(key);
    } else {
      await CacheHelper.saveData(key: key, value: value);
    }
  }

  Future<void> deleteAccount() async {
    await userApi.deleteAccount();
  }
}
