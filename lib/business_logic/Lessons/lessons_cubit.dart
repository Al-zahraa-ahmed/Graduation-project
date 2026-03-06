import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/business_logic/Categories/categories_cubit.dart';
import 'package:graduation_project/data/Models/LessonsModel.dart';
import 'package:meta/meta.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(LessonsInitial());
  final CategoriesApi categoriesApi = CategoriesApi();

  
  Future<void> loadLessons({required int id}) async {
    emit(LessonsLoading());
    try {
      final  r1 = await categoriesApi.getLessons(id: id);
      final  r2 = await categoriesApi.getProgress(id: id);
      emit(LessonsSuccess(lessons: r1, progress: r2));
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("DATA: ${e.response?.data}");
      print("MESSAGE: ${e.message}");
      emit(LessonsError('Failed to load categories'));
    }

  }
}
