part of 'quiz_cubit.dart';

sealed class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizzesLoaded extends QuizState {
  final List<QuizModel> quizzes;
  QuizzesLoaded(this.quizzes);
}

class QuizError extends QuizState {
  final String message;
  QuizError(this.message);
}

/// Quiz in-progress: user is answering questions
class QuizInProgress extends QuizState {
  final int quizId;
  final int userQuizId;
  final int durationMins;
  final List<QuestionModel> questions;
  final Map<int, int> selectedAnswers; // questionId -> option number (1-4)
  final int currentIndex;

  QuizInProgress({
    required this.quizId,
    required this.userQuizId,
    required this.durationMins,
    required this.questions,
    required this.selectedAnswers,
    required this.currentIndex,
  });

  int get totalQuestions => questions.length;
  QuestionModel get currentQuestion => questions[currentIndex];
  bool get allAnswered => selectedAnswers.length == questions.length;

  QuizInProgress copyWith({
    Map<int, int>? selectedAnswers,
    int? currentIndex,
  }) {
    return QuizInProgress(
      quizId: quizId,
      userQuizId: userQuizId,
      durationMins: durationMins,
      questions: questions,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class QuizSubmitting extends QuizState {}

class QuizResultLoaded extends QuizState {
  final int quizId;
  final int userQuizId;
  final QuizResultModel result;
  QuizResultLoaded({
    required this.quizId,
    required this.userQuizId,
    required this.result,
  });
}

class QuizReviewLoading extends QuizState {}

/// Review mode: same as quiz screen but showing correct/wrong answers
class QuizReviewInProgress extends QuizState {
  final List<ReviewAnswerModel> reviewAnswers;
  final int currentIndex;

  QuizReviewInProgress({
    required this.reviewAnswers,
    required this.currentIndex,
  });

  int get totalQuestions => reviewAnswers.length;
  ReviewAnswerModel get currentQuestion => reviewAnswers[currentIndex];

  QuizReviewInProgress copyWith({int? currentIndex}) {
    return QuizReviewInProgress(
      reviewAnswers: reviewAnswers,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
