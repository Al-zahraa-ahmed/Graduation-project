import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  resetPassword({required String reset_token,required String pass,required String pass2})async{
        final Dio dio = Dio(BaseOptions(baseUrl: "https://signlingo.org/api/"));
emit(ResetPasswordLoading());
    try {
      final Response r = await dio.post(
        "https://signlingo.org/api/reset-password",
        data: {"reset_token": reset_token, "password": pass,"password_confirmation":pass2},
      );

      print(r);
    
      emit(ResetPasswordSuccess());
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      emit(ResetPasswordFailure(errmsg: e.response?.data.toString() ?? "errors"));
    } on Exception catch (e) {
      print(e.toString());
      emit(ResetPasswordFailure(errmsg: e.toString()));
    }
  }
  
}
