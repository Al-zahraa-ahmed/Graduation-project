import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Lessons/lessons_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/CustomSegmentedControl.dart';
import 'package:graduation_project/presentation/Lessons/Widgets/lesson.dart';
import 'package:graduation_project/presentation/PlayVideo/VideoScreen.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key, required this.id, required this.title});
  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LessonsCubit()..loadLessons(id: id),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 90,
          centerTitle: true,
          leading: Row(
            children: [
              const SizedBox(width: 20),
              IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: const Color(0xffD6D6F5)),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.chevron_left),
              ),
            ],
          ),
          title: Text(title, style: Textstyles.medium25),
        ),
        body: const _LessonsBody(),
      ),
    );
  }
}

class _LessonsBody extends StatelessWidget {
  const _LessonsBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LessonsCubit, LessonsState>(
      listenWhen: (prev, curr) =>
          prev is LessonsLoaded &&
          curr is LessonsLoaded &&
          prev.togglingIds.length > curr.togglingIds.length,
      listener: (context, state) {
        // No-op for now — kept for future toggle-failure surfacing.
      },
      builder: (context, state) {
        if (state is LessonsError) {
          return _ErrorState(
            message: S.of(context).lessons_load_failed,
            onRetry: () => context.read<LessonsCubit>().retry(),
          );
        }
        if (state is! LessonsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  S.of(context).lessons_count_label(state.progress),
                  style: Textstyles.medium13.copyWith(
                    color: const Color(0xff999999),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomSegmentedControl(
                isAllSelected: state.tab == LessonsTab.all,
                onChanged: (isAll) => context
                    .read<LessonsCubit>()
                    .switchTab(isAll ? LessonsTab.all : LessonsTab.viewed),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: state.visible.isEmpty
                    ? _EmptyViewedState(tab: state.tab)
                    : ListView.builder(
                        itemCount: state.visible.length,
                        itemBuilder: (context, i) {
                          final lesson = state.visible[i];
                          final cubit = context.read<LessonsCubit>();
                          return Lesson(
                            l: lesson,
                            index: i + 1,
                            isToggling:
                                state.togglingIds.contains(lesson.id),
                            onToggle: () => cubit.toggleLesson(lesson.id),
                            onOpen: () {
                              // Opening a lesson marks it done immediately
                              // (idempotent — re-watching won't un-mark it).
                              cubit.markDone(lesson.id);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LessonVideoScreen(
                                    videoUrl: lesson.link,
                                    title: isArabic()
                                        ? lesson.name.ar
                                        : lesson.name.en,
                                    desc: lesson.desc,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyViewedState extends StatelessWidget {
  const _EmptyViewedState({required this.tab});
  final LessonsTab tab;

  @override
  Widget build(BuildContext context) {
    // For the "All" tab being empty means the category has no lessons —
    // surface a minimal message; for "Viewed" empty is normal & guided.
    final isViewedTab = tab == LessonsTab.viewed;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isViewedTab
                ? Icons.bookmark_border_rounded
                : Icons.menu_book_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          Text(
            isViewedTab
                ? S.of(context).lessons_empty_viewed
                : S.of(context).lessons_empty_viewed,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (isViewedTab) ...[
            const SizedBox(height: 8),
            Text(
              S.of(context).lessons_empty_viewed_hint,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(S.of(context).retry),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8484E1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
