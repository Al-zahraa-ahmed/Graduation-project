import 'package:flutter/material.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/AnswerButton.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/CircularNumberProgress.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/QuestionCard.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/arrowbackandnext.dart';
import 'package:graduation_project/presentation/QuizResult/QuizResult.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 1;

  final int totalQuestions = 15;

  void nextQuestion() {
    if (currentQuestion == totalQuestions) {
      showFinishDialog();
    } else {
      setState(() {
        currentQuestion++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestion > 1) {
      setState(() {
        currentQuestion--;
      });
    }
  }

  void showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10), // دي المهمة

          child: Container(
            padding: EdgeInsets.all(12),
            // margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                const Text(
                  "Quiz Completed!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You’ve reached the end of the quiz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    backgroundColor: const Color(0xff7C7CD5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (buildcontext) {
                          return QuickResult();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Submit",
                    style: Textstyles.medium20.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("Assets/images/Group 1.png"),
              Positioned(
                top: 30,
                left: 20,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Color(0xffD6D6F5),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.chevron_left),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          Container(
            // color: Colors.red,
            child: Stack(
              children: [
                Stack(
                  alignment: AlignmentGeometry.centerLeft,
                  clipBehavior: Clip.none,
                  children: [
                    QuistionCard(),
                    Positioned(
                      left: 10,
                      child: Arrowbackandnext(
                        icon: Icon(Icons.chevron_left),
                        onpressed: previousQuestion,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Arrowbackandnext(
                          icon: Icon(Icons.chevron_right),
                          onpressed: nextQuestion,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: CircularNumberProgress(
                    number: currentQuestion,
                    progress: currentQuestion / totalQuestions,
                  ),
                ),
              ],
            ),
          ),
          AnswerButton(),
          SizedBox(height: 12),
          AnswerButton(),
          SizedBox(height: 12),
          AnswerButton(),
          SizedBox(height: 12),
          AnswerButton(),
        ],
      ),
    );
  }
}

//  ***************************************************************************
