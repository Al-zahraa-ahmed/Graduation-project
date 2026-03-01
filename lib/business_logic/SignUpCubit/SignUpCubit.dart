import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'SignUpState.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final Dio dio = Dio(BaseOptions(
    baseUrl: "https://signlingo.org/api/"
  ));
 Future<void> SignUp({
    required String name,
    required String email,
    required String password,
    required String password2,
    required bool agreement,
  }) async {
    print(dio.options.baseUrl);
    emit(SignUpLoading());
    try {
      final Response = await dio.post(
        "https://signlingo.org/api/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password2,
          "agreement": agreement,
        },
      );
      print(Response);
      final int userid = Response.data['user_id'];
      emit(SignUpSuccess(userid: userid));
    }  on DioException catch (e) {
  print("STATUS: ${e.response?.statusCode}");
  print("RESPONSE DATA: ${e.response?.data}");
  emit(SignUpFailure(errormsg: e.response?.data.toString() ?? "errors"));
}
    on Exception catch (e) {
      print(e.toString());
      emit(SignUpFailure(errormsg: e.toString()));
    }
  }
}
