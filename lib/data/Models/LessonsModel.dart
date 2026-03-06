import 'package:graduation_project/data/Models/CategoryModel.dart';

class LessonsModel {
  final int id;
  final LocalizedText name;
  final LocalizedText desc;
  final String link;
  final bool iswatched;

  LessonsModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.link,
    required this.iswatched,
  });
  factory LessonsModel.fromJson(Map<String, dynamic> json) {
    return LessonsModel(
      id: json['id'],
      name: LocalizedText.fromJsonString(json['name'] ?? ''),
      desc: LocalizedText.fromJsonString(json['desc'] ?? ''),
      link: json['link'],
      iswatched: json['done'],
    );
  }
}
