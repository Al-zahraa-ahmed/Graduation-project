import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:graduation_project/Core/Network/auth_interceptor.dart';
import 'package:graduation_project/data/Models/SpeechToTextResultModel.dart';

/// Talks to the backend speech-to-text model (`POST /api/speech-to-text`).
///
/// NOTE: This is the server-side STT path. The app currently transcribes speech
/// on-device via the `speech_to_text` package; this service is an alternative
/// backend integration and is intentionally NOT wired into the UI.
class SpeechToTextApiService {
  late final Dio dio;

  SpeechToTextApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://signlingo.org/api/",
        headers: {"Accept": "application/json"},
        // Audio uploads + model inference can be slow — be generous.
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );
    // Inject the bearer token at request-time.
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper.getData("token");
          if (token is String && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          handler.next(options);
        },
      ),
    );
    // On 401, clear token + route to login (same as the other authed services).
    dio.interceptors.add(AuthInterceptor());
  }

  /// Uploads a local audio file and returns its transcription.
  ///
  /// [audioFilePath] is a path to an audio file (e.g. `.wav`, `.ogg`, `.m4a`).
  /// The backend expects a multipart `audio` field.
  Future<SpeechToTextResultModel> transcribe(String audioFilePath) async {
    try {
      final formData = FormData.fromMap({
        "audio": await MultipartFile.fromFile(audioFilePath),
      });
      final response = await dio.post("speech-to-text", data: formData);

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception("Unexpected speech-to-text response");
      }
      return SpeechToTextResultModel.fromJson(data);
    } on DioException catch (e) {
      // Backend errors come as either {"error": "..."} or {"message": "..."}.
      final data = e.response?.data;
      String? msg;
      if (data is Map) {
        msg = (data['error'] ?? data['message'])?.toString();
      }
      throw Exception(msg ?? "Speech-to-text failed");
    }
  }
}
