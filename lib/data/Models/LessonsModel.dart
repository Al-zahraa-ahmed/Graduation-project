import 'package:graduation_project/data/Models/CategoryModel.dart';

class LessonsModel {
  final int id;
  final LocalizedText name;
  final LocalizedText? desc;
  final String link;

  /// Backend returns a pre-formatted duration string like `"00:03"`.
  /// May be missing on some endpoints (e.g. viewed-lessons before backend
  /// alignment), so it's nullable.
  final String? duration;
  final bool done;

  LessonsModel({
    required this.id,
    required this.name,
    required this.link,
    this.desc,
    this.duration,
    this.done = false,
  });

  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    final descRaw = json['desc'];
    return LessonsModel(
      id: json['id'] as int,
      name: LocalizedText.fromJsonString((json['name'] ?? '').toString()),
      desc: (descRaw == null || descRaw.toString().isEmpty)
          ? null
          : LocalizedText.fromJsonString(descRaw.toString()),
      link: (json['link'] ?? '').toString(),
      // Field name varies between endpoints — backend returns `duration_secs`
      // on /categories/{id}/lesson and `duration_sec` on /viewed-lessons.
      duration: (json['duration_secs'] ?? json['duration_sec'])?.toString(),
      done: json['done'] as bool? ?? false,
    );
  }

  LessonsModel copyWith({bool? done}) => LessonsModel(
        id: id,
        name: name,
        desc: desc,
        link: link,
        duration: duration,
        done: done ?? this.done,
      );
}
