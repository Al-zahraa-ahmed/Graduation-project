import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://signlingo.org/api/",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  Future<void> Login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    if (isClosed || state is LoginLoading) return;
    emit(LoginLoading());
    try {
      final Response r = await dio.post(
        "https://signlingo.org/api/login",
        data: {
          "email": email,
          "password": password,
          "remember_me": rememberMe,
        },
      );

      // Validate response shape before reading.
      final data = r.data;
      if (data is! Map || data['data'] is! Map) {
        if (isClosed) return;
        emit(LoginFailure(
          errmsg: 'Unexpected server response. Please try again.',
        ));
        return;
      }
      final inner = data['data'] as Map;
      final token = inner['token'];
      final rawUser = inner['user'];
      if (token is! String ||
          token.isEmpty ||
          rawUser is! Map) {
        if (isClosed) return;
        emit(LoginFailure(
          errmsg: 'Unexpected server response. Please try again.',
        ));
        return;
      }

      await CacheHelper.saveData(key: "token", value: token);
      final userJson = Map<String, dynamic>.from(rawUser);
      final user = UserModel.fromJson(userJson);
      await CacheHelper.saveData(
        key: "user",
        value: jsonEncode(user.toJson()),
      );
      // Sync server-side preferences into local cache so returning users
      // land in the right home (not onboarding's cached value or a default).
      if (user.mode != null && user.mode!.isNotEmpty) {
        await CacheHelper.saveData(key: "mode", value: user.mode!);
      }
      if (user.language != null && user.language!.isNotEmpty) {
        await CacheHelper.saveData(key: "lang", value: user.language!);
      }

      if (isClosed) return;
      emit(LoginSuccess(token: token));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(LoginFailure(errmsg: ApiException.fromDio(e).message));
    } catch (_) {
      if (isClosed) return;
      emit(LoginFailure(
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
