import 'package:pusher/features/auth/data/models/user_model.dart';

class User {
  final int id;
  final String email;
  final String password;
  final String username;

  const User({
    required this.id,
    required this.email,
    this.password = '',
    this.username = '',
  });

  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      password: password,
      username: username,
    );
  }
}
