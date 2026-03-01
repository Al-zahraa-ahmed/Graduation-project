import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Errors/ApiExceptions.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  /// ==================== GET ====================
  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      return await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: _buildOptions(token),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  /// ==================== POST ====================
  Future<Response> post({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      return await dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(token),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  /// ==================== PUT ====================
  Future<Response> put({
    required String endpoint,
    dynamic data,
    String? token,
  }) async {
    try {
      return await dio.put(
        endpoint,
        data: data,
        options: _buildOptions(token),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  /// ==================== PATCH ====================
  Future<Response> patch({
    required String endpoint,
    dynamic data,
    String? token,
  }) async {
    try {
      return await dio.patch(
        endpoint,
        data: data,
        options: _buildOptions(token),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  /// ==================== DELETE ====================
  Future<Response> delete({
    required String endpoint,
    dynamic data,
    String? token,
  }) async {
    try {
      return await dio.delete(
        endpoint,
        data: data,
        options: _buildOptions(token),
      );
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  /// ==================== OPTIONS BUILDER ====================
  Options _buildOptions(String? token) {
    return Options(
      headers: {
        if (token != null) "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
  }
}