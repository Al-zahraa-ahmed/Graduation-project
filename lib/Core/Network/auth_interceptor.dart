import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/main.dart' show navigatorKey;
import 'package:graduation_project/presentation/LogIn/LoginScreen.dart';

/// Global 401 handler. When any authenticated request comes back
/// `401 Unauthenticated` (expired / revoked / restored-stale token), it clears
/// the cached token and bounces the user to the login screen.
///
/// Attach to the `Dio` of services that hit authenticated endpoints. Do NOT
/// attach to the login/signup/forgot-password flows — a 401 there is a normal
/// "wrong credentials" response, not a session expiry.
class AuthInterceptor extends Interceptor {
  // Guards against several in-flight requests all 401-ing at once and each
  // pushing its own login screen.
  static bool _redirecting = false;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _forceLogout();
    }
    handler.next(err);
  }

  Future<void> _forceLogout() async {
    if (_redirecting) return;
    _redirecting = true;

    await CacheHelper.removeData('token');

    final navigator = navigatorKey.currentState;
    if (navigator != null) {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => Loginscreen()),
        (route) => false,
      );
    }

    // Release the guard shortly after so a *future* session expiry can trigger
    // the redirect again.
    Future.delayed(const Duration(seconds: 1), () => _redirecting = false);
  }
}
