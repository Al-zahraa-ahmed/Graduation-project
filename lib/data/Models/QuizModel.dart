import 'package:graduation_project/data/Models/CategoryModel.dart';

/// Quiz object from GET /quizes
class QuizModel {
  final int id;
  final LocalizedText name;
  final LocalizedText desc;
  final String img;

  QuizModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.img,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      name: LocalizedText.fromJsonString(json['name'] ?? ''),
      desc: LocalizedText.fromJsonString(json['desc'] ?? ''),
      img: (json['img'] ?? '').toString(),
    );
  }
}

/// Question object from GET /quizes/{id}
/// Options are option1-4, each is LocalizedText
/// answer is the correct option number (1-4)
class QuestionModel {
  final int id;
  final LocalizedText title;
  final String media;
  final LocalizedText option1;
  final LocalizedText option2;
  final LocalizedText option3;
  final LocalizedText option4;
  final int answer; // correct option number 1-4
  final int quizId;

  QuestionModel({
    required this.id,
    required this.title,
    required this.media,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answer,
    required this.quizId,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      title: LocalizedText.fromJsonString(json['title'] ?? ''),
      media: (json['media'] ?? '').toString(),
      option1: LocalizedText.fromJsonString(json['option1'] ?? ''),
      option2: LocalizedText.fromJsonString(json['option2'] ?? ''),
      option3: LocalizedText.fromJsonString(json['option3'] ?? ''),
      option4: LocalizedText.fromJsonString(json['option4'] ?? ''),
      answer: json['answer'] ?? 0,
      quizId: json['quiz_id'] ?? 0,
    );
  }

  /// Get option text by number (1-4)
  LocalizedText getOption(int number) {
    switch (number) {
      case 1:
        return option1;
      case 2:
        return option2;
      case 3:
        return option3;
      case 4:
        return option4;
      default:
        return option1;
    }
  }
}

/// Response from POST /quizes/{id}/start
class QuizStartResult {
  final int userQuizId;
  final int durationMins;
  final int noQuestions;

  QuizStartResult({
    required this.userQuizId,
    required this.durationMins,
    required this.noQuestions,
  });

  factory QuizStartResult.fromJson(Map<String, dynamic> json) {
    return QuizStartResult(
      userQuizId: json['user_quiz_id'],
      durationMins: json['duration_mins'] ?? 0,
      noQuestions: json['no_questions'] ?? 0,
    );
  }
}

/// Response from POST /quizes/{id}/submit
class QuizResultModel {
  final int attemp;
  final int score;
  final int totalQuestions;
  final int percentage;
  final String feedback;
  final double timeMins;
  final bool timeUp;
  final String shareToken;

  QuizResultModel({
    required this.attemp,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.feedback,
    required this.timeMins,
    required this.timeUp,
    required this.shareToken,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      attemp: json['attemp'] ?? 0,
      score: json['score'] ?? 0,
      totalQuestions: json['total_questions'] ?? 0,
      percentage: json['percentage'] ?? 0,
      feedback: (json['feedback'] ?? '').toString(),
      timeMins: (json['time_mins'] is num)
          ? (json['time_mins'] as num).toDouble()
          : double.tryParse(json['time_mins']?.toString() ?? '0') ?? 0,
      timeUp: json['time_up'] ?? false,
      shareToken: (json['share_token'] ?? '').toString(),
    );
  }
}

/// Single review answer from GET /quizes/{id}/review/{attemptId}
class ReviewAnswerModel {
  final int questionId;
  final LocalizedText title;
  final Map<String, LocalizedText> options; // "1" -> LocalizedText, etc.
  final int? userAnswer; // option number or null
  final int correctAnswer; // option number
  final bool isCorrect;

  ReviewAnswerModel({
    required this.questionId,
    required this.title,
    required this.options,
    this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });

  factory ReviewAnswerModel.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'] as Map<String, dynamic>? ?? {};
    final parsedOptions = rawOptions.map(
      (key, value) => MapEntry(key, LocalizedText.fromJsonString(value ?? '')),
    );

    return ReviewAnswerModel(
      questionId: json['question_id'] ?? 0,
      title: LocalizedText.fromJsonString(json['title'] ?? ''),
      options: parsedOptions,
      userAnswer: json['user_answer'],
      correctAnswer: json['correct_answer'] ?? 0,
      isCorrect: json['is_correct'] ?? false,
    );
  }
}
