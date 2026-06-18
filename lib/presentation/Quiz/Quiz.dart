import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Core/TextStyles/TextStyles.dart';
import 'package:graduation_project/business_logic/Quiz/quiz_cubit.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/AnswerButton.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/CircularNumberProgress.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/QuestionCard.dart';
import 'package:graduation_project/presentation/Quiz/Widgets/arrowbackandnext.dart';
import 'package:graduation_project/generated/l10n.dart';
import 'package:graduation_project/presentation/QuizResult/QuizResult.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.quizId});
  final int quizId;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Timer? _timer;
  int _totalSeconds = 0;
  bool _timerStarted = false;

  // Kept in a notifier so the per-second tick repaints ONLY the countdown
  // ring, not the whole quiz body (question card, image, answer buttons).
  final ValueNotifier<int> _remaining = ValueNotifier<int>(0);

  void _startTimer(int durationMins) {
    if (_timerStarted) return;
    _timerStarted = true;
    _totalSeconds = durationMins * 60;
    _remaining.value = _totalSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.value <= 0) {
        timer.cancel();
        // Time's up — auto submit
        context.read<QuizCubit>().submitQuiz(timeUp: true);
      } else {
        _remaining.value--;
      }
    });
  }

  static String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    _remaining.dispose();
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
                icon: const Icon(Icons.chevron_left),
              ),
            ),
            body: Center(
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
                    S.of(context).something_went_wrong,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => context.read<QuizCubit>().retry(),
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
            ),
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
    final ar = isArabic();
    final prevIcon = ar ? Icons.chevron_right : Icons.chevron_left;
    final nextIcon = ar ? Icons.chevron_left : Icons.chevron_right;

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
                  PositionedDirectional(
                    top: 30,
                    start: 20,
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
                    alignment: AlignmentDirectional.centerStart,
                    clipBehavior: Clip.none,
                    children: [
                      QuistionCard(
                      questionNumber: state.currentIndex + 1,
                      totalQuestions: state.totalQuestions,
                      questionText: ar
                          ? question.title.ar
                          : question.title.en,
                      mediaUrl: question.media,
                    ),
                    PositionedDirectional(
                      start: 10,
                      child: Arrowbackandnext(
                        icon: Icon(prevIcon),
                        onpressed: () => cubit.previousQuestion(),
                      ),
                    ),
                    PositionedDirectional(
                      end: 10,
                      child: Arrowbackandnext(
                        icon: Icon(nextIcon),
                        onpressed: () {
                          if (isLastQuestion) {
                            _showFinishDialog(context, state);
                          } else {
                            cubit.nextQuestion();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ValueListenableBuilder<int>(
                    valueListenable: _remaining,
                    builder: (context, remaining, _) => CircularNumberProgress(
                      text: _formatTime(remaining),
                      progress: _totalSeconds > 0
                          ? remaining / _totalSeconds
                          : 0.0,
                    ),
                  ),
                ),
              ],
            ),
            for (int i = 1; i <= 4; i++) ...[
              AnswerButton(
                text: ar
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
                  S.of(context).quiz_leave_title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1E1E7B),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  S.of(context).quiz_leave_desc,
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
                          S.of(context).quiz_leave_btn,
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
                          S.of(context).quiz_stay_btn,
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
    final ar = isArabic();
    final prevIcon = ar ? Icons.chevron_right : Icons.chevron_left;
    final nextIcon = ar ? Icons.chevron_left : Icons.chevron_right;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("Assets/images/Group 1.png"),
                PositionedDirectional(
                  top: 30,
                  start: 20,
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
                  alignment: AlignmentDirectional.centerStart,
                  clipBehavior: Clip.none,
                  children: [
                    QuistionCard(
                      questionNumber: state.currentIndex + 1,
                      totalQuestions: state.totalQuestions,
                      questionText: ar
                          ? review.title.ar
                          : review.title.en,
                      mediaUrl: review.media,
                    ),
                    PositionedDirectional(
                      start: 10,
                      child: Arrowbackandnext(
                        icon: Icon(prevIcon),
                        onpressed: () => cubit.previousReviewQuestion(),
                      ),
                    ),
                    PositionedDirectional(
                      end: 10,
                      child: Arrowbackandnext(
                        icon: Icon(nextIcon),
                        onpressed: () => cubit.nextReviewQuestion(),
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
                    ar ? entry.value.ar : entry.value.en;
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
                  S.of(context).quiz_completed_title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  state.allAnswered
                      ? S.of(context).quiz_answered_all(state.totalQuestions)
                      : S.of(context).quiz_answered_partial(state.selectedAnswers.length, state.totalQuestions),
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
                    S.of(context).submit_btn1,
                    style: Textstyles.medium20.copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(S.of(context).submit_btn2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
