import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/data/Models/ProfileModel.dart';
import 'package:graduation_project/data/Services/UserApiService.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final UserApiService userApi = UserApiService();

  Future<void> getMainData() async {
    try {
      emit(ProfileLoading());
      final response = await userApi.getUserMainData();
      if (isClosed) return;
      emit(ProfileSucces(user: response));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: e.toString()));
    } on Exception catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: e.toString()));
    }
  }

  Future<void> changelang({required String lang}) async {
    if (state is ProfileSucces) {
      final currentUser = (state as ProfileSucces).user;
      emit(ProfileSucces(user: currentUser.copyWith(language: lang)));
    }
    try {
      await userApi.changeLanguage(language: lang);
      await CacheHelper.saveData(key: 'lang', value: lang);
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: e.toString()));
    } on Exception catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: e.toString()));
    }
  }

  Future<void> changeMode({required String mode}) async {
    if (state is ProfileSucces) {
      final currentUser = (state as ProfileSucces).user;
      emit(ProfileSucces(user: currentUser.copyWith(mode: mode)));
    }
    try {
      await userApi.changeMode(mode: mode);
      await CacheHelper.saveData(key: 'mode', value: mode);
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: e.toString()));
    } on Exception catch (e) {
      if (isClosed) return;
      emit(ProfileFailure(errmsg: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    await userApi.deleteAccount();
  }
}
