import 'package:bloc/bloc.dart';
import 'package:graduation_project/data/Models/QuizModel.dart';
import 'package:graduation_project/data/Services/QuizApiService.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  final QuizApiService _api = QuizApiService();

  int? _lastQuizId;

  /// Load all quizzes for the QuickPractice grid
  Future<void> loadQuizzes() async {
    emit(QuizLoading());
    try {
      final quizzes = await _api.getQuizzes();
      emit(QuizzesLoaded(quizzes));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  /// Start a quiz: fetch questions + create an attempt on the server
  Future<void> startQuiz({required int quizId}) async {
    emit(QuizLoading());
    try {
      final results = await Future.wait([
        _api.getQuestions(quizId: quizId),
        _api.startQuiz(quizId: quizId),
      ]);

      final questions = results[0] as List<QuestionModel>;
      final startResult = results[1] as QuizStartResult;

      _lastQuizId = quizId;

      emit(QuizInProgress(
        quizId: quizId,
        userQuizId: startResult.userQuizId,
        durationMins: startResult.durationMins,
        questions: questions,
        selectedAnswers: {},
        currentIndex: 0,
      ));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  /// Select an answer for a question (option number 1-4)
  void selectAnswer({required int questionId, required int optionNumber}) {
    final current = state;
    if (current is! QuizInProgress) return;

    final updated = Map<int, int>.from(current.selectedAnswers);
    updated[questionId] = optionNumber;

    emit(current.copyWith(selectedAnswers: updated));
  }

  void nextQuestion() {
    final current = state;
    if (current is! QuizInProgress) return;
    if (current.currentIndex < current.totalQuestions - 1) {
      emit(current.copyWith(currentIndex: current.currentIndex + 1));
    }
  }

  void previousQuestion() {
    final current = state;
    if (current is! QuizInProgress) return;
    if (current.currentIndex > 0) {
      emit(current.copyWith(currentIndex: current.currentIndex - 1));
    }
  }

  /// Submit the quiz
  Future<void> submitQuiz({bool timeUp = false}) async {
    final current = state;
    if (current is! QuizInProgress) return;

    emit(QuizSubmitting());
    try {
      // Backend expects sequential keys "1","2","3"... not question IDs
      final Map<String, int> answers = {};
      for (int i = 0; i < current.questions.length; i++) {
        final questionId = current.questions[i].id;
        if (current.selectedAnswers.containsKey(questionId)) {
          answers[(i + 1).toString()] = current.selectedAnswers[questionId]!;
        }
      }

      print("=== SUBMIT DEBUG ===");
      print("selectedAnswers: ${current.selectedAnswers}");
      print("questions count: ${current.questions.length}");
      print("answers to send: $answers");
      print("userQuizId: ${current.userQuizId}");
      print("====================");

      final result = await _api.submitQuiz(
        quizId: current.quizId,
        userQuizId: current.userQuizId,
        answers: answers,
      );

      emit(QuizResultLoaded(
        quizId: current.quizId,
        userQuizId: current.userQuizId,
        result: result,
      ));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  /// Load review answers and enter review mode
  Future<void> loadReview({
    required int quizId,
    required int attemptId,
  }) async {
    emit(QuizReviewLoading());
    try {
      final review = await _api.reviewQuiz(
        quizId: quizId,
        attemptId: attemptId,
      );
      emit(QuizReviewInProgress(
        reviewAnswers: review,
        currentIndex: 0,
      ));
    } catch (e) {
      emit(QuizError(e.toString()));
    }
  }

  void nextReviewQuestion() {
    final current = state;
    if (current is! QuizReviewInProgress) return;
    if (current.currentIndex < current.totalQuestions - 1) {
      emit(current.copyWith(currentIndex: current.currentIndex + 1));
    }
  }

  void previousReviewQuestion() {
    final current = state;
    if (current is! QuizReviewInProgress) return;
    if (current.currentIndex > 0) {
      emit(current.copyWith(currentIndex: current.currentIndex - 1));
    }
  }

  /// Generate a share link
  Future<String?> generateShareLink({required int attemptId}) async {
    try {
      return await _api.generateShareLink(attemptId: attemptId);
    } catch (e) {
      return null;
    }
  }

  /// Play again — restart the same quiz
  Future<void> playAgain() async {
    if (_lastQuizId != null) {
      await startQuiz(quizId: _lastQuizId!);
    }
  }
}
