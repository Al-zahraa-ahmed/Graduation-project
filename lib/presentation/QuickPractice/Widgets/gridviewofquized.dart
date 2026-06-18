import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/QuickPractice/Widgets/quizcard.dart';

class GridviewOfQuiz extends StatelessWidget {
  const GridviewOfQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is QuizLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is QuizError) {
          return _QuizErrorState(
            onRetry: () => context.read<QuizCubit>().loadQuizzes(),
          );
        }
        if (state is QuizzesLoaded) {
          final quizzes = state.quizzes;
          if (quizzes.isEmpty) {
            return Center(child: Text(S.of(context).quiz_no_quizzes));
          }
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
            ),
            itemCount: quizzes.length,
            itemBuilder: (BuildContext context, int index) {
              return QuizCard(quiz: quizzes[index]);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _QuizErrorState extends StatelessWidget {
  const _QuizErrorState({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 56,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            S.of(context).quiz_load_failed,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
