import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://signlingo.org/api/",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  Future<void> resetPassword({
    required String reset_token,
    required String pass,
    required String pass2,
  }) async {
    if (isClosed || state is ResetPasswordLoading) return;
    emit(ResetPasswordLoading());
    try {
      await dio.post(
        "reset-password",
        data: {
          "reset_token": reset_token,
          "password": pass,
          "password_confirmation": pass2,
        },
      );

      if (isClosed) return;
      emit(ResetPasswordSuccess());
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ResetPasswordFailure(errmsg: ApiException.fromDio(e).message));
    } catch (_) {
      if (isClosed) return;
      emit(ResetPasswordFailure(
        errmsg: 'Something went wrong. Please try again.',
      ));
    }
  }

  @override
  Future<void> close() {
    dio.close(force: true);
    return super.close();
  }
}
