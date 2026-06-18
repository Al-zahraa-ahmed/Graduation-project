import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:meta/meta.dart';
part 'SignUpState.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://signlingo.org/api/",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  Future<void> SignUp({
    required String name,
    required String email,
    required String password,
    required String password2,
    required bool agreement,
  }) async {
    if (isClosed || state is SignUpLoading) return;
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

      final data = response.data;
      final userid = data is Map ? data['user_id'] : null;
      if (userid is! int) {
        if (isClosed) return;
        emit(SignUpFailure(
          errormsg: 'Unexpected server response. Please try again.',
        ));
        return;
      }

      if (isClosed) return;
      emit(SignUpSuccess(userid: userid));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(SignUpFailure(errormsg: ApiException.fromDio(e).message));
    } catch (_) {
      if (isClosed) return;
      emit(SignUpFailure(
        errormsg: 'Something went wrong. Please try again.',
      ));
    }
  }

  @override
  Future<void> close() {
    dio.close(force: true);
    return super.close();
  }
}
