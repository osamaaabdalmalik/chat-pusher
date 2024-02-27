import 'package:pusher/features/auth/domain/entities/user_entity.dart';

class UserAuth {
  final User user;
  final String token;

  const UserAuth({
    required this.user,
    required this.token,
  });
}
