import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/data/Models/QuizModel.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/Quiz/Quiz.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  void _startRandom(BuildContext context, List<QuizModel> quizzes) {
    final quiz = quizzes[Random().nextInt(quizzes.length)];
    // Mirror QuizCard: a fresh QuizCubit drives the quiz session.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => QuizCubit()..startQuiz(quizId: quiz.id),
          child: QuizScreen(quizId: quiz.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        final quizzes =
            state is QuizzesLoaded ? state.quizzes : const <QuizModel>[];
        final enabled = quizzes.isNotEmpty;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: const Color(0xffD6D6F5),
            disabledBackgroundColor:
                const Color(0xffD6D6F5).withValues(alpha: 0.5),
          ),
          onPressed: enabled ? () => _startRandom(context, quizzes) : null,
          child: Text(
            S.of(context).quiz_btn,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
