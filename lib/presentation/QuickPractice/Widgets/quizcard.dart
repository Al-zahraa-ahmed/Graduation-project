import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/data/Models/QuizModel.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/presentation/Quiz/Quiz.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});

  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    final name = isArabic() ? quiz.name.ar : quiz.name.en;
    final desc = isArabic() ? quiz.desc.ar : quiz.desc.en;

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xffADADEB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
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
          borderRadius: BorderRadius.circular(12),
          splashColor: const Color(0x33FFFFFF),
          highlightColor: const Color(0x1AFFFFFF),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                quiz.img.isNotEmpty
                    ? Image.network(
                        quiz.img,
                        height: 36,
                        width: 36,
                        color: Colors.white,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          );
                        },
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.quiz,
                          size: 36,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.quiz, size: 36, color: Colors.white),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: Textstyles.medium20.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
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
      ),
    );
  }
}
