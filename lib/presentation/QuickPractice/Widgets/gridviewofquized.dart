import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
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
          return Center(child: Text(state.message));
        }
        if (state is QuizzesLoaded) {
          final quizzes = state.quizzes;
          if (quizzes.isEmpty) {
            return const Center(child: Text("No quizzes available"));
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
