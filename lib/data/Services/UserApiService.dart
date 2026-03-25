import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/data/Models/UserModel.dart';
// import 'user_model.dart';
// import 'cache_helper.dart';

class UserApiService {
  late final Dio dio;

  UserApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://signlingo.org/api/user/",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getData("token")}",
        },
      ),
    );
  }

  Future<void> selectModeFirstTime({required String mode}) async {
    try {
      await dio.patch("select-mode", data: {"mode": mode});
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to select mode");
    }
  }

  Future<UserModel> getUserMainData() async {
    try {
      final response = await dio.get(
        "https://signlingo.org/api/user/main-data",
      );
      final data = response.data["data"];
      print(data);
      return UserModel.fromJson(data);
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
    String? username,
    String? email,
    String? phone,
  }) async {
    try {
      await dio.post(
        "update-data",
        data: {
          if (username != null) "username": username,
          if (email != null) "email": email,
          if (phone != null) "phone": phone,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to update user data",
      );
    }
  }

  Future<void> changeLanguage({required String language}) async {
    try {
      await dio.patch("change-lang", data: {"lang": language});
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to change language",
      );
    }
  }

  Future<void> deleteAccount() async {
    try {
      await dio.post("delete-account");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to delete account",
      );
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
    try {
      await dio.patch("change-mode", data: {"mode": mode});
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to change mode");
    }
  }

  Future<void> changeTheme({required String theme}) async {
    try {
      await dio.patch("change-theme", data: {"theme": theme});
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to change theme");
    }
  }
}
