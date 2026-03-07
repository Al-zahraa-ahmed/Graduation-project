import 'package:graduation_project/data/Models/CategoryModel.dart';

class WordModel {
  final String word;
  final String link;
  final String category;
  final LocalizedText desc;

  WordModel({required this.word, required this.link, required this.category, required this.desc});

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      word: json['word'] ?? '',
      link: json['link'] ?? '',
      category: json['category'] ?? '',
      desc: LocalizedText.fromJsonString(json['desc'] ?? ''),
    );
  }

}