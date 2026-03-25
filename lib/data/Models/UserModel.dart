class UserModel {
  final int id;
  final String username;
  final String email;
  final int isVerified;
 final String? language;
  final String? mode;
  final String? theme;
  final String? img;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.isVerified, this.language, this.mode, this.theme, this.img,
    
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      username: json["username"] ?? json["userName"]??"",
      email: json["email"] ?? json["userEmail"]??"",
      isVerified: json["is_verified"] ?? 0,
      language: json["userLang"] ?? json["lang"],
      mode: json["userMode"],
      theme: json["theme"],
      img: json["img"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "is_verified": isVerified,
    };
  }

   UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? phone,
    String? language,
    String? mode,
    String? theme,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      language: language ?? this.language,
      mode: mode ?? this.mode,
      theme: theme ?? this.theme, 
      isVerified: isVerified,
    );
  }
}