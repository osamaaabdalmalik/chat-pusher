import 'package:pusher/features/auth/domain/entities/user_entity.dart';

class Message {
  final int id;
  final String content;
  final String createdAt;
  final int chatId;
  final User user;

  const Message({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.chatId,
    required this.user,
  });
}
