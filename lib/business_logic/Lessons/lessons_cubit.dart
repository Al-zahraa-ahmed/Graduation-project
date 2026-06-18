import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/business_logic/Categories/categories_cubit.dart';
import 'package:graduation_project/data/Models/LessonsModel.dart';
import 'package:meta/meta.dart';

part 'lessons_state.dart';

class LessonsCubit extends Cubit<LessonsState> {
  LessonsCubit() : super(LessonsInitial());
  final CategoriesApi _api = CategoriesApi();

  int? _categoryId;

  Future<void> loadLessons({required int id}) async {
    _categoryId = id;
    emit(LessonsLoading());
    try {
      final results = await Future.wait([
        _api.getLessons(id: id),
        _api.getProgress(id: id),
      ]);
      if (isClosed) return;
      emit(LessonsLoaded(
        all: results[0] as List<LessonsModel>,
        progress: results[1] as String,
      ));
    } on DioException {
      if (isClosed) return;
      emit(LessonsError('Failed to load lessons'));
    }
  }

  void switchTab(LessonsTab tab) {
    final s = state;
    if (s is! LessonsLoaded || s.tab == tab) return;
    emit(s.copyWith(tab: tab));
  }

  /// Optimistic + reconcile + background sync (hybrid):
  ///   1. Flip `done` locally and recompute progress → instant UI feedback.
  ///   2. POST /toggle; reconcile the flag with the server's authoritative value.
  ///   3. Silently re-fetch /lessons-progress so the count matches the backend.
  /// On failure, revert.
  Future<void> toggleLesson(int lessonId) async {
    final s = state;
    if (s is! LessonsLoaded) return;
    if (s.togglingIds.contains(lessonId)) return;

    final lesson = s.all.firstWhere((l) => l.id == lessonId);
    final newDone = !lesson.done;

    final optimisticAll = _flip(s.all, lessonId, newDone);
    emit(s.copyWith(
      all: optimisticAll,
      progress: _localProgress(optimisticAll),
      togglingIds: {...s.togglingIds, lessonId},
    ));

    try {
      final serverDone = await _api.toggleLesson(lessonId: lessonId);
      if (isClosed) return;
      final cur = state;
      if (cur is! LessonsLoaded) return;
      final reconciledAll = _flip(cur.all, lessonId, serverDone);
      emit(cur.copyWith(
        all: reconciledAll,
        progress: _localProgress(reconciledAll),
        togglingIds: cur.togglingIds.difference({lessonId}),
      ));
      _syncProgress();
    } on DioException {
      if (isClosed) return;
      final cur = state;
      if (cur is! LessonsLoaded) return;
      final revertedAll = _flip(cur.all, lessonId, lesson.done);
      emit(cur.copyWith(
        all: revertedAll,
        progress: _localProgress(revertedAll),
        togglingIds: cur.togglingIds.difference({lessonId}),
      ));
    }
  }

  /// Idempotent "mark as done" used when opening a lesson — never un-marks a
  /// lesson the user re-watches. No-op (and no API call) if already done.
  Future<void> markDone(int lessonId) async {
    final s = state;
    if (s is! LessonsLoaded) return;
    final lesson = s.all.firstWhere((l) => l.id == lessonId);
    if (lesson.done || s.togglingIds.contains(lessonId)) return;
    await toggleLesson(lessonId);
  }

  /// Re-fetch the authoritative progress string without blocking the UI.
  Future<void> _syncProgress() async {
    final id = _categoryId;
    if (id == null) return;
    try {
      final fresh = await _api.getProgress(id: id);
      if (isClosed) return;
      final cur = state;
      if (cur is LessonsLoaded) emit(cur.copyWith(progress: fresh));
    } on DioException {
      // Background reconcile failed — keep the optimistic local value.
    }
  }

  Future<void> retry() async {
    final id = _categoryId;
    if (id == null) return;
    await loadLessons(id: id);
  }

  static List<LessonsModel> _flip(
    List<LessonsModel> list,
    int lessonId,
    bool done,
  ) =>
      list
          .map((l) => l.id == lessonId ? l.copyWith(done: done) : l)
          .toList();

  static String _localProgress(List<LessonsModel> list) =>
      '${list.where((l) => l.done).length} / ${list.length}';
}
