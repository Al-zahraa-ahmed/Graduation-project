import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/data/Models/QuizModel.dart';
import 'package:graduation_project/presentation/LearningHome/learninghome.dart';
import 'package:graduation_project/presentation/Quiz/Quiz.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/AmazingContainer.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/ExamResult.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/ScoreContainer.dart';
import 'package:graduation_project/presentation/QuizResult/Widgets/quickReviewButtons.dart';
import 'package:share_plus/share_plus.dart';

class QuickResult extends StatelessWidget {
  const QuickResult({
    super.key,
    required this.quizId,
    required this.userQuizId,
    required this.result,
  });

  final int quizId;
  final int userQuizId;
  final QuizResultModel result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("Assets/images/Group 1.png"),
            SizedBox(height: 12),
            Amazingcontainer(feedback: result.feedback),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
              child: Card(
                elevation: 4,
                color: Colors.white,
                child: Column(
                  children: [
                    ScoreContainer(
                      score: result.score,
                      totalQuestions: result.totalQuestions,
                      timeMins: result.timeMins,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "Assets/images/fireworksleft.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(width: 5),
                        ExamResult(percentage: result.percentage),
                        SizedBox(width: 5),
                        Image.asset(
                          "Assets/images/fireworksright.png",
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          QuickReviewButtons(
                            img: "Assets/images/replay.png",
                            txt: "Play Again",
                            onpressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) =>
                                        QuizCubit()..startQuiz(quizId: quizId),
                                    child: QuizScreen(quizId: quizId),
                                  ),
                                ),
                              );
                            },
                          ),
                          QuickReviewButtons(
                            img: "Assets/images/eye.png",
                            txt: "Review Answers",
                            onpressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (_) => QuizCubit()
                                      ..loadReview(
                                        quizId: quizId,
                                        attemptId: userQuizId,
                                      ),
                                    child: QuizScreen(quizId: quizId),
                                  ),
                                ),
                              );
                            },
                          ),
                          QuickReviewButtons(
                            img: "Assets/images/share.png",
                            txt: "Share Score",
                            onpressed: () async {
                              final cubit = QuizCubit();
                              final link = await cubit.generateShareLink(
                                attemptId: userQuizId,
                              );
                              if (link != null) {
                                SharePlus.instance.share(
                                  ShareParams(text: link),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "Assets/images/Fireworks bottomleft.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(width: 20),
                        QuickReviewButtons(
                          onpressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LearingHome(),
                              ),
                            );
                          },
                          img: "Assets/images/home.png",
                          txt: "Return Home",
                        ),
                        SizedBox(width: 20),
                        Image.asset(
                          "Assets/images/Fireworks bottomright.png",
                          height: 100,
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
