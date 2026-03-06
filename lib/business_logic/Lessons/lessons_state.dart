part of 'lessons_cubit.dart';

@immutable
sealed class LessonsState {}

final class LessonsInitial extends LessonsState {}

class LessonsLoading extends LessonsState {}

class LessonsSuccess extends LessonsState {
  final List<LessonsModel> lessons;
final String progress;
  LessonsSuccess({required this.progress ,required this.lessons}); // الأصل
}
class LessonsError extends LessonsState {
  final String message;
  LessonsError(this.message);
}
