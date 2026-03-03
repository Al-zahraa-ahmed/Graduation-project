import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  final Dio dio = Dio(BaseOptions(baseUrl: "https://signlingo.org/api/"));
  Future<void> forgetpassword({
    
    required String email,

  }) async {
    emit(ForgetPasswordLoading());
    try {
      final Response = await dio.post(
        "https://signlingo.org/api/forget-otp",
        data: {
          "email": email,
        },
      );
      print(Response);

      emit(ForgetPasswordSuccess());
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      emit(ForgetPasswordFailure(errmsg: e.response?.data.toString() ?? "errors"));
    } on Exception catch (e) {
      print(e.toString());
      emit(ForgetPasswordFailure(errmsg: e.toString()));
    }
  }



  
}
