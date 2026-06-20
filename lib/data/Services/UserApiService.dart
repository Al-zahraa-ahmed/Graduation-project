import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/Network/auth_interceptor.dart';
import 'package:graduation_project/data/Models/ProfileModel.dart';
import 'package:graduation_project/data/Models/UserModel.dart';

class UserApiService {
  late final Dio dio;

  UserApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://signlingo.org/api/user/",
        headers: {"Accept": "application/json"},
      ),
    );
    // Read the token at request-time so this Dio instance can outlive token
    // changes (e.g., the instance was created before the user logged in).
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper.getData("token");
          if (token is String && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          handler.next(options);
        },
      ),
    );
    // On 401 (stale/expired/revoked token), clear it and bounce to login.
    dio.interceptors.add(AuthInterceptor());
  }

  Future<void> selectModeFirstTime({required String mode}) async {
    try {
      await dio.patch("select-mode", data: {"mode": mode});
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to select mode");
    }
  }

  Future<ProfileModel> getUserMainData() async {
    try {
      final response = await dio.get("main-data");
      final data = response.data["data"];
      return ProfileModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to get main data");
    }
  }

  Future<UserModel> getUserAllData() async {
    try {
      final response = await dio.get("all-data");
      final data = response.data["data"];
      return UserModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to get all data");
    }
  }

  Future<void> updateUserData({
    required String username,
    required String name,
    required String email,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    String? imgPath,
    bool removeImage = false,
  }) async {
    try {
      final formData = FormData.fromMap({
        "username": username,
        "name": name,
        "email": email,
        if (currentPassword != null && currentPassword.isNotEmpty)
          "current_password": currentPassword,
        if (newPassword != null && newPassword.isNotEmpty)
          "new_password": newPassword,
        if (confirmPassword != null && confirmPassword.isNotEmpty)
          "confirm_password": confirmPassword,
        if (imgPath != null)
          "img": await MultipartFile.fromFile(imgPath),
        if (removeImage) "remove_image": "1",
      });
      await dio.post("update-data", data: formData);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to update user data",
      );
    }
  }

  Future<void> changeLanguage({required String language}) async {
    await dio.patch("change-lang", data: {"lang": language});
  }

  Future<void> deleteAccount() async {
    try {
      // Backend route only accepts DELETE (POST returns 405).
      await dio.delete("delete-account");
    } on DioException catch (e) {
      final data = e.response?.data;
      final msg = (data is Map && data['message'] != null)
          ? data['message'].toString()
          : 'Failed to delete account';
      throw Exception(msg);
    }
  }

  Future<String> getName() async {
    try {
      final response = await dio.get("get-name");
      final data = response.data["data"];
      return data["username"] ?? data["name"] ?? "";
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to get name");
    }
  }

  Future<void> changeMode({required String mode}) async {
    await dio.patch("change-mode", data: {"mode": mode});
  }

  Future<void> changeTheme({required String theme}) async {
    await dio.patch("change-theme", data: {"theme": theme});
  }
}
