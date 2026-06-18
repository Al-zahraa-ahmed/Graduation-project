class PhraseModel {
  final String id;
  final String text;
  final bool pinned;
  final DateTime createdAt;

  PhraseModel({
    required this.id,
    required this.text,
    this.pinned = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  PhraseModel copyWith({String? text, bool? pinned}) => PhraseModel(
        id: id,
        text: text ?? this.text,
        pinned: pinned ?? this.pinned,
        createdAt: createdAt,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'pinned': pinned,
        'createdAt': createdAt.toIso8601String(),
      };

  factory PhraseModel.fromJson(Map<String, dynamic> json) => PhraseModel(
        id: json['id'] as String,
        text: json['text'] as String,
        pinned: (json['pinned'] as bool?) ?? false,
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );
}
