import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
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
      print(response.language);
      emit(ProfileSucces(user: response));
    } on DioException catch (e) {
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      emit(ProfileFailure(errmsg: e.toString()));
    } on Exception catch (e) {
      emit(ProfileFailure(errmsg: e.toString()));
    }
  }

  Future<void> changelang({required String lang}) async {
    try {
      await userApi.changeLanguage(language: lang);
      emit(ChangeLangSuccess());
    } on DioException catch (e) {
      print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      emit(ChangeLangFailure(errmsg: e.toString()));
    } on Exception catch (e) {
      emit(ChangeLangFailure(errmsg: e.toString()));
    }
  }
}
