import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({
    required this.message,
    this.statusCode,
  });

  factory ApiException.fromDio(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(message: "Connection timeout");

      case DioExceptionType.sendTimeout:
        return ApiException(message: "Send timeout");

      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Receive timeout");

      case DioExceptionType.badResponse:
        return ApiException(
          message: dioException.response?.data["message"] ??
              "Server error",
          statusCode: dioException.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return ApiException(message: "Request cancelled");

      case DioExceptionType.connectionError:
        return ApiException(message: "No internet connection");

      default:
        return ApiException(message: "Unexpected error occurred");
    }
  }

  @override
  String toString() => message;
}