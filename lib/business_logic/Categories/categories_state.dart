part of 'categories_cubit.dart';

sealed class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryModel> all;      // الأصل
  final List<CategoryModel> visible;  // اللي ظاهر
  CategoriesSuccess({required this.all, required this.visible});
}
class CategoriesError extends CategoriesState {
  final String message;
  CategoriesError(this.message);
}