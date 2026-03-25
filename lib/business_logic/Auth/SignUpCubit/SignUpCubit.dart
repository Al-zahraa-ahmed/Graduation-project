import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
part 'SignUpState.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final Dio dio = Dio(BaseOptions(baseUrl: "https://signlingo.org/api/"));
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
      final response = await dio.post(
        "https://signlingo.org/api/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": password2,
          "agreement": agreement,
        },
      );
        print("STATUS: ${response.statusCode}");
      print("DATA: ${response.data}");
      final int userid = response.data['user_id'];
      emit(SignUpSuccess(userid: userid));
    } on DioException catch (e) {
          print("TYPE: ${e.type}");
      print("MESSAGE: ${e.message}");
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
       String errorMessage = "Something went wrong";

      if (e.response?.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;

        if (data["message"] != null) {
          errorMessage = data["message"].toString();
        }

        if (data["errors"] != null) {
          errorMessage += "\n${data["errors"]}";
        }
      } else if (e.message != null) {
        errorMessage = e.message!;
      }
      emit(SignUpFailure(errormsg: errorMessage));
    } on Exception catch (e) {
         print(e.toString());
      emit(SignUpFailure(errormsg: e.toString()));
      emit(SignUpFailure(errormsg: e.toString()));
    }
  }
}
