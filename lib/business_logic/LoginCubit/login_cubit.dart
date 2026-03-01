import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
 final Dio dio = Dio(BaseOptions(
    baseUrl: "https://signlingo.org/api/"
  ));
  Future<void> Login({
    required String email,
    required String password,
    required bool agreement,
  }) async {
    print(dio.options.baseUrl);
    emit(LoginLoading());
    try {
      final Response r= await dio.post(
        "https://signlingo.org/api/login",
        data: {
          
          "email": email,
          "password": password,
          "agreement": agreement,
        },
      );
      print(Response);
      final String token = r.data["data"]["token"];
      await CacheHelper.saveData(key: "token", value: token);
      emit(LoginSuccess());
    }  on DioException catch (e) {
  print("STATUS: ${e.response?.statusCode}");
  print("RESPONSE DATA: ${e.response?.data}");
  emit(LoginFailure(errmsg: e.response?.data.toString() ?? "errors"));
}
    on Exception catch (e) {
      print(e.toString());
      emit(LoginFailure(errmsg: e.toString()));
    }
  }
}
