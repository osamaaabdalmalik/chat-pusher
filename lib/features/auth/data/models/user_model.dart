import 'package:pusher/features/auth/domain/entities/user_entity.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.password,
    super.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json.containsKey("password") ? json['password'] : '',
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'username': username,
    };
  }
}
