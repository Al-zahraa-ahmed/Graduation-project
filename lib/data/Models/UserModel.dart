class UserModel {
  final int id;
  final String username;
  final String email;
  final int isVerified;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      isVerified: json["is_verified"] ?? 0,
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
}