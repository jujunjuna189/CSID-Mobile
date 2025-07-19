class ModelLogin {
  ModelLogin({
    required this.id,
    this.username,
    this.email,
    this.phone,
    this.displayName,
    this.avatar,
  });

  final int id;
  final String? username;
  final String? email;
  final String? phone;
  final String? displayName;
  final String? avatar;

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        id: json['id'] is! int ? int.parse((json['id'] ?? '0')) : json['id'],
        username: json["username"] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        displayName: json['display_name'] ?? "",
        avatar: json['avatar'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "display_name": displayName,
        "avatar": avatar,
      };
}
