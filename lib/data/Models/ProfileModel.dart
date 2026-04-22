class ProfileModel {
  final String username;
  final String email;
 final String? language;
  final String? mode;
  final String? theme;
  final String? img;
  ProfileModel({
    required this.username,
    required this.email,
    this.language, this.mode, this.theme, this.img,
    
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json["username"] ?? json["userName"]??"",
      email: json["email"] ?? json["userEmail"]??"",
      language: json["userLang"] ?? json["lang"],
      mode: json["userMode"],
      theme: json["theme"],
      img: json["img"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "userLang":language,
      "mode":mode,
      "theme":theme,
      "img":img
    };
  }

   ProfileModel copyWith({
    String? username,
    String? email,
    String? language,
    String? mode,
    String? theme,
    final String? img
  }) {
    return ProfileModel(
      username: username ?? this.username,
      email: email ?? this.email,
      language: language ?? this.language,
      mode: mode ?? this.mode,
      theme: theme ?? this.theme, 
      img: img ?? this.img,
    );
  }
}