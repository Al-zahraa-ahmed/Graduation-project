import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/AnswerButton.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/CircularNumberProgress.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/QuestionCard.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/arrowbackandnext.dart';
import 'package:graduation_project/presentation/QuizResult/QuizResult.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quizId});
  final int quizId;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _timerStarted = false;

  void _startTimer(int durationMins) {
    if (_timerStarted) return;
    _timerStarted = true;
    _remainingSeconds = durationMins * 60;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
        // Time's up — auto submit
        context.read<QuizCubit>().submitQuiz(timeUp: true);
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String get _formattedTime {
    final mins = _remainingSeconds ~/ 60;
    final secs = _remainingSeconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: (context, state) {
        if (state is QuizResultLoaded) {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => QuickResult(
                quizId: state.quizId,
                userQuizId: state.userQuizId,
                result: state.result,
              ),
            ),
          );
        }
        // Start timer when quiz loads
        if (state is QuizInProgress && !_timerStarted) {
          _startTimer(state.durationMins);
        }
      },
      builder: (context, state) {
        if (state is QuizLoading || state is QuizSubmitting || state is QuizReviewLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is QuizError) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.chevron_left),
              ),
            ),
            body: Center(child: Text(state.message)),
          );
        }
        if (state is QuizInProgress) {
          return _buildQuizBody(context, state);
        }
        if (state is QuizReviewInProgress) {
          return _buildReviewBody(context, state);
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  // ==================== QUIZ MODE ====================

  Widget _buildQuizBody(BuildContext context, QuizInProgress state) {
    final cubit = context.read<QuizCubit>();
    final question = state.currentQuestion;
    final selectedOption = state.selectedAnswers[question.id];
    final isLastQuestion = state.currentIndex == state.totalQuestions - 1;
    final lang = CacheHelper.getData("lang") ?? "en";
    final totalSeconds = state.durationMins * 60;
    final timerProgress = totalSeconds > 0 ? _remainingSeconds / totalSeconds : 0.0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _showLeaveDialog(context);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                      onPressed: () => _showLeaveDialog(context),
                      icon: Icon(Icons.chevron_left),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  Stack(
                    alignment: AlignmentGeometry.centerLeft,
                    clipBehavior: Clip.none,
                    children: [
                      QuistionCard(
                      questionNumber: state.currentIndex + 1,
                      totalQuestions: state.totalQuestions,
                      questionText: lang == "ar"
                          ? question.title.ar
                          : question.title.en,
                      mediaUrl: question.media,
                    ),
                    Positioned(
                      left: 10,
                      child: Arrowbackandnext(
                        icon: Icon(Icons.chevron_left),
                        onpressed: () => cubit.previousQuestion(),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Arrowbackandnext(
                          icon: Icon(Icons.chevron_right),
                          onpressed: () {
                            if (isLastQuestion) {
                              _showFinishDialog(context, state);
                            } else {
                              cubit.nextQuestion();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: CircularNumberProgress(
                    text: _formattedTime,
                    progress: timerProgress,
                  ),
                ),
              ],
            ),
            for (int i = 1; i <= 4; i++) ...[
              AnswerButton(
                text: lang == "ar"
                    ? question.getOption(i).ar
                    : question.getOption(i).en,
                answerState: selectedOption == i
                    ? AnswerState.selected
                    : AnswerState.normal,
                onTap: () {
                  cubit.selectAnswer(
                    questionId: question.id,
                    optionNumber: i,
                  );
                },
              ),
              SizedBox(height: 12),
            ],
          ],
        ),
      ),
    ),
    );
  }

  // ==================== LEAVE DIALOG ====================

  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Leave Quiz?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1E1E7B),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "You will lose all your progress\nif you leave now.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Color(0xffADADEB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          _timer?.cancel();
                          Navigator.pop(dialogContext);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Leave",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Color(0xff7C7CD5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(
                          "Stay",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==================== REVIEW MODE ====================

  Widget _buildReviewBody(BuildContext context, QuizReviewInProgress state) {
    final cubit = context.read<QuizCubit>();
    final review = state.currentQuestion;
    final lang = CacheHelper.getData("lang") ?? "en";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.chevron_left),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                Stack(
                  alignment: AlignmentGeometry.centerLeft,
                  clipBehavior: Clip.none,
                  children: [
                    QuistionCard(
                      questionNumber: state.currentIndex + 1,
                      totalQuestions: state.totalQuestions,
                      questionText: lang == "ar"
                          ? review.title.ar
                          : review.title.en,
                    ),
                    Positioned(
                      left: 10,
                      child: Arrowbackandnext(
                        icon: Icon(Icons.chevron_left),
                        onpressed: () => cubit.previousReviewQuestion(),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Arrowbackandnext(
                          icon: Icon(Icons.chevron_right),
                          onpressed: () => cubit.nextReviewQuestion(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            for (final entry in review.options.entries) ...[
              Builder(builder: (context) {
                final optionNum = int.tryParse(entry.key) ?? 0;
                final optionText =
                    lang == "ar" ? entry.value.ar : entry.value.en;
                final isCorrect = optionNum == review.correctAnswer;
                final isUserWrong =
                    optionNum == review.userAnswer && !isCorrect;

                AnswerState answerState;
                if (isCorrect) {
                  answerState = AnswerState.correct;
                } else if (isUserWrong) {
                  answerState = AnswerState.wrong;
                } else {
                  answerState = AnswerState.untouched;
                }

                return AnswerButton(
                  text: optionText,
                  answerState: answerState,
                  onTap: null,
                );
              }),
              SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  // ==================== FINISH DIALOG ====================

  void _showFinishDialog(BuildContext context, QuizInProgress state) {
    final cubit = context.read<QuizCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Text(
                  "Quiz Completed!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  state.allAnswered
                      ? "You've answered all ${state.totalQuestions} questions."
                      : "You've answered ${state.selectedAnswers.length} of ${state.totalQuestions} questions.\nPlease answer all questions before submitting.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    backgroundColor: state.allAnswered
                        ? const Color(0xff7C7CD5)
                        : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: state.allAnswered
                      ? () {
                          Navigator.pop(dialogContext);
                          cubit.submitQuiz();
                        }
                      : null,
                  child: Text(
                    "Submit",
                    style: Textstyles.medium20.copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
