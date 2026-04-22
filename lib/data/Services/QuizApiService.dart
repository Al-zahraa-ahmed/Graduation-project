import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/data/Models/QuizModel.dart';

class QuizApiService {
  late final Dio dio;

  QuizApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://signlingo.org/api/",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer ${CacheHelper.getData("token")}",
        },
      ),
    );
  }

  /// GET /quizes
  Future<List<QuizModel>> getQuizzes() async {
    try {
      final response = await dio.get("quizes");
      final List data = response.data['data'];
      return data.map((e) => QuizModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to load quizzes");
    }
  }

  /// GET /quizes/{id} — returns questions for this quiz
  Future<List<QuestionModel>> getQuestions({required int quizId}) async {
    try {
      final response = await dio.get("quizes/$quizId");
      final List data = response.data['data'];
      return data.map((e) => QuestionModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to load questions",
      );
    }
  }

  /// POST /quizes/{id}/start — returns user_quiz_id, duration_mins, no_questions
  Future<QuizStartResult> startQuiz({required int quizId}) async {
    try {
      final response = await dio.post("quizes/$quizId/start");
      return QuizStartResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to start quiz");
    }
  }

  /// POST /quizes/{id}/submit
  /// answers: map of questionId (as String) -> selected option number (1-4)
  Future<QuizResultModel> submitQuiz({
    required int quizId,
    required int userQuizId,
    required Map<String, int> answers,
  }) async {
    try {
      final response = await dio.post(
        "quizes/$quizId/submit",
        data: {
          "user_quiz_id": userQuizId,
          "answers": answers,
        },
      );
      return QuizResultModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to submit quiz");
    }
  }

  /// GET /quizes/{id}/review/{attemptId}
  Future<List<ReviewAnswerModel>> reviewQuiz({
    required int quizId,
    required int attemptId,
  }) async {
    try {
      final response = await dio.get("quizes/$quizId/review/$attemptId");
      final List data = response.data['data'];
      return data.map((e) => ReviewAnswerModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to load review",
      );
    }
  }

  /// GET /share/generate-link/{attemptId} — returns share_link URL
  Future<String> generateShareLink({required int attemptId}) async {
    try {
      final response = await dio.get("share/generate-link/$attemptId");
      return response.data['data']['share_link'];
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to generate share link",
      );
    }
  }
}
