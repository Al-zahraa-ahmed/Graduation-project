part of 'lessons_cubit.dart';

enum LessonsTab { all, viewed }

@immutable
sealed class LessonsState {}

final class LessonsInitial extends LessonsState {}

class LessonsLoading extends LessonsState {}

class LessonsError extends LessonsState {
  final String message;
  LessonsError(this.message);
}

class LessonsLoaded extends LessonsState {
  final List<LessonsModel> all;

  /// Authoritative progress string from `/lessons-progress` (e.g. "3 / 17").
  /// Updated optimistically on toggle for instant feedback, then reconciled
  /// by a silent background re-fetch.
  final String progress;

  final LessonsTab tab;

  /// Ids mid-flight on the toggle endpoint — UI shows a per-row spinner so the
  /// user can't double-tap the same lesson.
  final Set<int> togglingIds;

  LessonsLoaded({
    required this.all,
    required this.progress,
    this.tab = LessonsTab.all,
    this.togglingIds = const {},
  });

  /// Derived from the lessons' `done` flags so the Viewed tab stays in sync
  /// instantly on every toggle.
  List<LessonsModel> get viewed => all.where((l) => l.done).toList();

  List<LessonsModel> get visible => tab == LessonsTab.all ? all : viewed;

  LessonsLoaded copyWith({
    List<LessonsModel>? all,
    String? progress,
    LessonsTab? tab,
    Set<int>? togglingIds,
  }) =>
      LessonsLoaded(
        all: all ?? this.all,
        progress: progress ?? this.progress,
        tab: tab ?? this.tab,
        togglingIds: togglingIds ?? this.togglingIds,
      );
}
