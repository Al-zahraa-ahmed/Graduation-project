import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message:
              'The request timed out. Please check your internet connection and try again.',
        );

      case DioExceptionType.connectionError:
        return ApiException(
          message:
              'Unable to connect to the server. Please check your internet connection.',
        );

      case DioExceptionType.cancel:
        return ApiException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return ApiException(
          message: 'Secure connection failed. Please try again later.',
        );

      case DioExceptionType.badResponse:
        return _fromBadResponse(e);

      case DioExceptionType.unknown:
        return ApiException(
          message: 'Something went wrong. Please try again.',
        );
    }
  }

  static ApiException _fromBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    // Try to extract a friendly message from common response shapes:
    // 1. Laravel-style: {"message": "...", "errors": {"field": ["msg"]}}
    // 2. Simple: {"message": "..."}
    // 3. {"error": "..."}
    String? serverMessage;
    if (data is Map<String, dynamic>) {
      // Validation errors take precedence — surface the first one or two.
      if (data['errors'] is Map<String, dynamic>) {
        final errors = data['errors'] as Map<String, dynamic>;
        final flat = errors.values
            .whereType<List>()
            .expand((list) => list.whereType<String>())
            .toList();
        if (flat.isNotEmpty) {
          serverMessage = flat.take(2).join('\n');
        }
      }
      serverMessage ??=
          data['message']?.toString() ?? data['error']?.toString();
    }

    return ApiException(
      message: serverMessage ?? _statusCodeMessage(statusCode),
      statusCode: statusCode,
    );
  }

  static String _statusCodeMessage(int? code) {
    switch (code) {
      case 400:
        return 'Invalid request. Please check your input and try again.';
      case 401:
        return 'Wrong email or password. Please try again.';
      case 403:
        return 'You don\'t have permission to do that.';
      case 404:
        return 'We couldn\'t find what you\'re looking for.';
      case 409:
        return 'That already exists. Please try something different.';
      case 422:
        return 'Some of your input is invalid. Please check and try again.';
      case 429:
        return 'Too many attempts. Please wait a moment and try again.';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Server is having trouble right now. Please try again later.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => message;
}
