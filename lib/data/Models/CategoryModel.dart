import 'dart:convert';

class LocalizedText {
  final String en;
  final String ar;

  LocalizedText({required this.en, required this.ar});

  factory LocalizedText.fromJsonString(String raw) {
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return LocalizedText(
        en: (map['en'] ?? '').toString(),
        ar: (map['ar'] ?? '').toString(),
      );
    } catch (_) {
      // لو جالك نص مش JSON لأي سبب
      return LocalizedText(en: raw, ar: raw);
    }
  }
}

class CategoryModel {
  final int id;
  final LocalizedText name;
  final LocalizedText desc;
  final String img;
  final int progress;

  CategoryModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.img,
    required this.progress,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: LocalizedText.fromJsonString(json['name'] ?? ''),
      desc: LocalizedText.fromJsonString(json['desc'] ?? ''),
      img: (json['img'] ?? '').toString(),
      progress: (json['progress'] ?? 0) is int
          ? (json['progress'] ?? 0)
          : int.tryParse(json['progress'].toString()) ?? 0,
    );
  }
}

