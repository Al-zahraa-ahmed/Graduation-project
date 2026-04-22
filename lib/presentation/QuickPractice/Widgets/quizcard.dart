import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/data/Models/QuizModel.dart';
import 'package:graduation_project/presentation/Quiz/Quiz.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    final lang = CacheHelper.getData("lang") ?? "en";
    final name = lang == "ar" ? quiz.name.ar : quiz.name.en;
    final desc = lang == "ar" ? quiz.desc.ar : quiz.desc.en;

    return GestureDetector(
      onTap: () {
        // Navigate to quiz screen, passing quizId
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => QuizCubit()..startQuiz(quizId: quiz.id),
              child: QuizScreen(quizId: quiz.id),
            ),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 155 / 155,
        child: Container(
          width: 152,
          height: 155,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xffADADEB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              quiz.img.isNotEmpty
                  ? Image.network(
                      quiz.img,
                      height: 36,
                      width: 36,
                      color: Colors.white,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.quiz, size: 36, color: Colors.white),
                    )
                  : Icon(Icons.quiz, size: 36, color: Colors.white),
              SizedBox(height: 8),
              Text(
                name,
                style: Textstyles.medium20.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    desc,
                    style: Textstyles.regular13.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
