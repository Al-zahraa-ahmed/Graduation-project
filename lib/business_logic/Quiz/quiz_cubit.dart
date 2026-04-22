import 'package:bloc/bloc.dart';
import 'package:graduation_project/data/Models/QuizModel.dart';
import 'package:graduation_project/data/Services/QuizApiService.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  final QuizApiService _api = QuizApiService();

  int? _lastQuizId;

  Future<void> loadQuizzes() async {
    emit(QuizLoading());
    try {
      final quizzes = await _api.getQuizzes();
      if (isClosed) return;
      emit(QuizzesLoaded(quizzes));
    } catch (e) {
      if (isClosed) return;
      emit(QuizError(e.toString()));
    }
  }

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

      if (isClosed) return;
      emit(QuizInProgress(
        quizId: quizId,
        userQuizId: startResult.userQuizId,
        durationMins: startResult.durationMins,
        questions: questions,
        selectedAnswers: {},
        currentIndex: 0,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(QuizError(e.toString()));
    }
  }

  void selectAnswer({required int questionId, required int optionNumber}) {
    final current = state;
    if (current is! QuizInProgress || isClosed) return;

    final updated = Map<int, int>.from(current.selectedAnswers);
    updated[questionId] = optionNumber;

    emit(current.copyWith(selectedAnswers: updated));
  }

  void nextQuestion() {
    final current = state;
    if (current is! QuizInProgress || isClosed) return;
    if (current.currentIndex < current.totalQuestions - 1) {
      emit(current.copyWith(currentIndex: current.currentIndex + 1));
    }
  }

  void previousQuestion() {
    final current = state;
    if (current is! QuizInProgress || isClosed) return;
    if (current.currentIndex > 0) {
      emit(current.copyWith(currentIndex: current.currentIndex - 1));
    }
  }

  Future<void> submitQuiz({bool timeUp = false}) async {
    final current = state;
    if (current is! QuizInProgress) return;

    emit(QuizSubmitting());
    try {
      final Map<String, int> answers = {};
      for (int i = 0; i < current.questions.length; i++) {
        final questionId = current.questions[i].id;
        if (current.selectedAnswers.containsKey(questionId)) {
          answers[(i + 1).toString()] = current.selectedAnswers[questionId]!;
        }
      }

      final result = await _api.submitQuiz(
        quizId: current.quizId,
        userQuizId: current.userQuizId,
        answers: answers,
      );

      if (isClosed) return;
      emit(QuizResultLoaded(
        quizId: current.quizId,
        userQuizId: current.userQuizId,
        result: result,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(QuizError(e.toString()));
    }
  }

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
      if (isClosed) return;
      emit(QuizReviewInProgress(
        reviewAnswers: review,
        currentIndex: 0,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(QuizError(e.toString()));
    }
  }

  void nextReviewQuestion() {
    final current = state;
    if (current is! QuizReviewInProgress || isClosed) return;
    if (current.currentIndex < current.totalQuestions - 1) {
      emit(current.copyWith(currentIndex: current.currentIndex + 1));
    }
  }

  void previousReviewQuestion() {
    final current = state;
    if (current is! QuizReviewInProgress || isClosed) return;
    if (current.currentIndex > 0) {
      emit(current.copyWith(currentIndex: current.currentIndex - 1));
    }
  }

  Future<String?> generateShareLink({required int attemptId}) async {
    try {
      return await _api.generateShareLink(attemptId: attemptId);
    } catch (e) {
      return null;
    }
  }

  Future<void> playAgain() async {
    if (_lastQuizId != null) {
      await startQuiz(quizId: _lastQuizId!);
    }
  }
}
