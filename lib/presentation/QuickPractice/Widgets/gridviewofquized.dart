
import 'package:flutter/material.dart';
import 'package:graduation_project/presentation/QuickPractice/Widgets/quizcard.dart';

class GridviewOfQuiz extends StatelessWidget {
  const GridviewOfQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
      ),
      itemCount: 16,
      itemBuilder: (BuildContext context, int index) {
        return QuizCard();
      },
    );
  }
}
