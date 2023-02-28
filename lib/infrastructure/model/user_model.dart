class UserModel {
  final String? name;
  final String? password;
  final String? avatar;
  final String? bio;
  final String? email;
  final String? phone;
  final String? level;

  UserModel( {
    required this.name,
    required this.password,
    this.avatar,
    this.bio,
    this.level,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic>? data) {
    return UserModel(
      name: data?["name"],
      password: data?["password"],
      avatar: data?["avatar"],
      bio: data?["bio"],
      email: data?["email"],
      phone: data?["phone"],
      level: data?["level"]
    );
  }

  toJson() {
    return {
      "name": name,
      "password": password,
      "avatar": avatar,
      "bio": bio,
      "email": email,
      "phone": phone,
      level:level,
    };
  }
}
