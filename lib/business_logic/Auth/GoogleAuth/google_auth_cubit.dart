import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
import 'package:graduation_project/data/Services/UserApiService.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthCubit() : super(GoogleAuthInitial());

  /// Web Client ID from the Google Cloud project that owns the backend's
  /// `/api/auth/google` endpoint. Public by design — embedded in client apps
  /// is the standard pattern. If the backend project changes, update here.
  static const String _serverClientId =
      '839640990656-ibhasotv6ho8l4vs3b2tfcsv2p8p41se.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: _serverClientId,
    scopes: const ['email', 'profile'],
  );

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://signlingo.org/api/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  Future<void> signInWithGoogle() async {
    if (isClosed || state is GoogleAuthLoading) return;
    emit(GoogleAuthLoading());

    // ignore: avoid_print
    print('[GoogleAuth] step 1: signOut() to force picker');
    try {
      try {
        await _googleSignIn.signOut();
      } catch (e) {
        // ignore: avoid_print
        print('[GoogleAuth] signOut threw (non-fatal): $e');
      }

      // ignore: avoid_print
      print('[GoogleAuth] step 2: signIn() — Google sheet should show');
      final GoogleSignInAccount? account;
      try {
        account = await _googleSignIn.signIn();
      } catch (e, stack) {
        // ignore: avoid_print
        print('[GoogleAuth] signIn THREW: $e');
        // ignore: avoid_print
        print('[GoogleAuth] stack: $stack');
        if (isClosed) return;
        emit(GoogleAuthFailure(message: 'signIn threw: $e'));
        return;
      }
      // ignore: avoid_print
      print('[GoogleAuth] step 3: signIn returned account=${account?.email}');

      if (account == null) {
        if (isClosed) return;
        emit(GoogleAuthFailure(message: 'No account picked (cancelled?)'));
        return;
      }

      // ignore: avoid_print
      print('[GoogleAuth] step 4: getting authentication tokens');
      final GoogleSignInAuthentication auth;
      try {
        auth = await account.authentication;
      } catch (e, stack) {
        // ignore: avoid_print
        print('[GoogleAuth] authentication THREW: $e');
        // ignore: avoid_print
        print('[GoogleAuth] stack: $stack');
        if (isClosed) return;
        emit(GoogleAuthFailure(message: 'authentication threw: $e'));
        return;
      }
      final idToken = auth.idToken;
      // ignore: avoid_print
      print('[GoogleAuth] step 5: idToken length=${idToken?.length ?? 0}');

      if (idToken == null || idToken.isEmpty) {
        if (isClosed) return;
        emit(GoogleAuthFailure(
          message: 'No idToken (check serverClientId + SHA-1 in Cloud project)',
        ));
        return;
      }

      // ignore: avoid_print
      print('[GoogleAuth] step 6: POST /api/auth/google');
      final response = await _dio.post(
        'auth/google',
        data: {'id_token': idToken},
      );
      if (isClosed) return;
      // ignore: avoid_print
      print('[GoogleAuth] step 7: backend status=${response.statusCode}, '
          'body=${response.data}');

      // `/api/auth/google` returns a different shape from `/api/login` —
      //   { message, access_token, token_type, user: { username, theme, mode } }
      // (no `data` envelope, `access_token` instead of `token`).
      final data = response.data;
      if (data is! Map) {
        emit(GoogleAuthFailure(
          message: 'Backend response not a map: ${response.data}',
        ));
        return;
      }
      final token = data['access_token'];
      final rawUser = data['user'];
      if (token is! String || token.isEmpty || rawUser is! Map) {
        emit(GoogleAuthFailure(
          message: 'Missing access_token/user in response: ${response.data}',
        ));
        return;
      }

      await CacheHelper.saveData(key: 'token', value: token);

      // `/api/auth/google` only returns a partial user (username, theme, mode)
      // — missing id, email, is_verified, lang, img. Hydrate from
      // `/user/all-data` which returns the full UserModel. If that call fails
      // (network/server), fall back to the partial Google user so the session
      // still proceeds; ProfileCubit.getMainData() on the home screen will
      // attempt a refresh later.
      UserModel user;
      try {
        // ignore: avoid_print
        print('[GoogleAuth] step 7.5: hydrating from /user/all-data');
        user = await UserApiService().getUserAllData();
      } catch (e) {
        // ignore: avoid_print
        print('[GoogleAuth] all-data hydration failed, using partial: $e');
        user = UserModel.fromJson(Map<String, dynamic>.from(rawUser));
      }
      if (isClosed) return;

      await CacheHelper.saveData(
        key: 'user',
        value: jsonEncode(user.toJson()),
      );
      if (user.mode != null && user.mode!.isNotEmpty) {
        await CacheHelper.saveData(key: 'mode', value: user.mode!);
      }
      if (user.language != null && user.language!.isNotEmpty) {
        await CacheHelper.saveData(key: 'lang', value: user.language!);
      }

      if (isClosed) return;
      // ignore: avoid_print
      print('[GoogleAuth] step 8: SUCCESS, navigating');
      emit(GoogleAuthSuccess(token: token));
    } on DioException catch (e) {
      // ignore: avoid_print
      print('[GoogleAuth] DioException: ${e.message}, '
          'status=${e.response?.statusCode}, body=${e.response?.data}');
      if (isClosed) return;
      emit(GoogleAuthFailure(
        message: 'Backend ${e.response?.statusCode}: ${e.response?.data}',
      ));
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('[GoogleAuth] PlatformException: code=${e.code}, '
          'message=${e.message}, details=${e.details}');
      if (isClosed) return;
      emit(GoogleAuthFailure(message: 'Google: ${e.code} — ${e.message}'));
    } catch (e, stack) {
      // ignore: avoid_print
      print('[GoogleAuth] Unexpected: $e\n$stack');
      if (isClosed) return;
      emit(GoogleAuthFailure(message: 'Unexpected: $e'));
    }
  }

  @override
  Future<void> close() {
    _dio.close(force: true);
    return super.close();
  }
}
