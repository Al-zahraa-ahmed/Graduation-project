/// Result returned by the backend speech-to-text model
/// (`POST /api/speech-to-text`).
class SpeechToTextResultModel {
  final String text;
  final double? durationSeconds;
  final String? filename;

  SpeechToTextResultModel({
    required this.text,
    this.durationSeconds,
    this.filename,
  });

  factory SpeechToTextResultModel.fromJson(Map<String, dynamic> json) {
    return SpeechToTextResultModel(
      text: (json['text'] ?? '').toString(),
      durationSeconds: json['duration_seconds'] is num
          ? (json['duration_seconds'] as num).toDouble()
          : null,
      filename: json['filename']?.toString(),
    );
  }
}
