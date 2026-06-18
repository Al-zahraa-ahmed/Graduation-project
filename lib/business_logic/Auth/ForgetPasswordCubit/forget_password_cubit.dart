import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://signlingo.org/api/",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  Future<void> forgetpassword({required String email}) async {
    if (isClosed || state is ForgetPasswordLoading) return;
    emit(ForgetPasswordLoading());
    try {
      final response = await dio.post(
        "forget-otp",
        data: {"email": email},
      );

      // Expected shape: {"data": {"user_id": <int>}, "message": "...", "status": 200}
      final body = response.data;
      final data = (body is Map) ? body['data'] : null;
      final userId = (data is Map) ? data['user_id'] : null;
      if (userId is! int) {
        if (isClosed) return;
        emit(ForgetPasswordFailure(
          errmsg: 'Unexpected server response. Please try again.',
        ));
        return;
      }

      if (isClosed) return;
      emit(ForgetPasswordSuccess(userId: userId));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(errmsg: ApiException.fromDio(e).message));
    } catch (_) {
      if (isClosed) return;
      emit(ForgetPasswordFailure(
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
