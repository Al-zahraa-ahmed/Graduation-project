import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/data/Services/UserApiService.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://signlingo.org/api/",
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  Future<void> resend_otp({required int userid}) async {
    if (isClosed || state is OtpLoading) return;
    emit(OtpLoading());
    try {
      await dio.post("resend-otp", data: {"user_id": userid});
      if (isClosed) return;
      emit(OtpResentSuccess());
    } on DioException catch (e) {
      if (isClosed) return;
      emit(OtpFailure(errmsg: ApiException.fromDio(e).message));
    } catch (_) {
      if (isClosed) return;
      emit(OtpFailure(errmsg: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> verify_otp({required int userid, required String otp}) async {
    if (isClosed || state is OtpLoading) return;
    emit(OtpLoading());
    try {
      final response = await dio.post(
        "verify-otp",
        data: {"user_id": userid, "otp": otp},
      );

      // Expected shape: {"data": {"token": "<jwt>", "user": {...}}, ...}
      final body = response.data;
      final data = (body is Map) ? body['data'] : null;
      final token = (data is Map) ? data['token'] : null;
      final userJson = (data is Map) ? data['user'] : null;
      if (token is! String || userJson is! Map) {
        if (isClosed) return;
        emit(OtpFailure(
          errmsg: 'Unexpected server response. Please try again.',
        ));
        return;
      }

      final user = UserModel.fromJson(Map<String, dynamic>.from(userJson));
      await CacheHelper.saveData(key: "token", value: token);
      await CacheHelper.saveData(key: "user", value: jsonEncode(user.toJson()));

      // Persist the mode the user picked during onboarding to the server.
      // True fire-and-forget — uses a separate UserApiService instance with
      // its own Dio (not the cubit's dio, which gets force-closed on close()).
      // `unawaited` + `catchError` keeps any failure from bubbling up as an
      // unhandled async error after the cubit has emitted Success.
      final pickedMode = CacheHelper.getData('mode') as String?;
      if (pickedMode != null && pickedMode.isNotEmpty) {
        unawaited(
          UserApiService()
              .selectModeFirstTime(mode: pickedMode)
              .catchError((_) {}),
        );
      }

      if (isClosed) return;
      emit(OtpVerifySuccess(token: token, user: user));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(OtpFailure(errmsg: ApiException.fromDio(e).message));
    } catch (_) {
      if (isClosed) return;
      emit(OtpFailure(errmsg: 'Something went wrong. Please try again.'));
    }
  }

  Future<void> verifyForgetPassword({
    required int userid,
    required String otp,
  }) async {
    if (isClosed || state is OtpLoading) return;
    emit(OtpLoading());
    try {
      final response = await dio.post(
        "verify-forget-otp",
        data: {"user_id": userid, "otp": otp},
      );

      // Expected shape: {"data": {"reset_token": "..."}, ...}
      final body = response.data;
      final data = (body is Map) ? body['data'] : null;
      final resetToken = (data is Map) ? data['reset_token'] : null;
      if (resetToken is! String) {
        if (isClosed) return;
        emit(OtpFailure(
          errmsg: 'Unexpected server response. Please try again.',
        ));
        return;
      }

      if (isClosed) return;
      emit(OtpForgetVerifySuccess(resetToken: resetToken));
    } on DioException catch (e) {
      if (isClosed) return;
      emit(OtpFailure(errmsg: ApiException.fromDio(e).message));
    } catch (_) {
      if (isClosed) return;
      emit(OtpFailure(errmsg: 'Something went wrong. Please try again.'));
    }
  }

  @override
  Future<void> close() {
    dio.close(force: true);
    return super.close();
  }
}
