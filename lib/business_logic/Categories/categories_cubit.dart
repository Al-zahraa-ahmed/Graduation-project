import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/data/Models/CategoryModel.dart';
import 'package:graduation_project/data/Models/LessonsModel.dart';
import 'package:graduation_project/data/Models/WordModel.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesApi {
  final Dio dio = Dio(BaseOptions());
  Future<List<CategoryModel>> getCategories() async {
    try {
      final token = CacheHelper.getData("token");
      final response = await dio.get(
        "https://signlingo.org/api/categories",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      List data = response.data['data'];
      print(token);
      return data.map((e) => CategoryModel.fromMap(e)).toList();
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("BODY: ${e.response?.data}");
      print("TOKEN: ${CacheHelper.getData("token")}");
      rethrow;
    }
  }

  Future<Map<String, List<WordModel>>> getDictionary() async {
    try {
      final token = CacheHelper.getData("token");
      final response = await dio.get(
        "https://signlingo.org/api/dictionary",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      Map<String, dynamic> data = response.data['data'];
      print(token);
      final Map<String, List<WordModel>> wordsByLetter = data.map(
  (key, value) => MapEntry(
    key,
    (value as List).map((e) => WordModel.fromJson(e)).toList(),
  ),
);
      return wordsByLetter;
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("BODY: ${e.response?.data}");
      print("TOKEN: ${CacheHelper.getData("token")}");
      rethrow;
    }
  }

  Future<List<LessonsModel>> getLessons({required int id}) async {
    try {
      final token = CacheHelper.getData("token");
      final response = await dio.get(
        "https://signlingo.org/api/categories/$id/lesson",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      List data = response.data['data'];
      print(data);
      print(token);
      return data.map((e) => LessonsModel.fromJson(e)).toList();
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("BODY: ${e.response?.data}");
      print("TOKEN: ${CacheHelper.getData("token")}");
      rethrow;
    }
  }

  Future<String> getProgress({required int id}) async {
    try {
      final token = CacheHelper.getData("token");
      final response = await dio.get(
        "https://signlingo.org/api/lessons-progress/$id",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      final data = response.data['data'];
      print(data);
      print(token);
      return data["progress"];
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("BODY: ${e.response?.data}");
      print("TOKEN: ${CacheHelper.getData("token")}");
      rethrow;
    }
  }
}


class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesLoading());
  final CategoriesApi categoriesApi = CategoriesApi();

  Timer? _debounce;

  Future<void> loadCategouries() async {
    emit(CategoriesLoading());
    try {
      final all = await categoriesApi.getCategories();
      emit(CategoriesSuccess(all: all, visible: all));
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("MESSAGE: ${e.message}");
      emit(CategoriesError('Failed to load categories'));
    }
  }

  void search(String q, {required bool isArabic}) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = q.trim().toLowerCase();

      final current = state;
      if (current is! CategoriesSuccess) return;

      // لو السيرش فاضي رجّع الكل
      if (query.isEmpty) {
        emit(CategoriesSuccess(all: current.all, visible: current.all));
        return;
      }

      final result = current.all.where((c) {
        final name = (isArabic ? c.name.ar : c.name.en).toLowerCase();
        final desc = (isArabic ? c.desc.ar : c.desc.en).toLowerCase();
        return name.contains(query) || desc.contains(query);
      }).toList();

      emit(CategoriesSuccess(all: current.all, visible: result));
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
