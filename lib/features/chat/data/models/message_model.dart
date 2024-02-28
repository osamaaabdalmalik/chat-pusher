import 'package:pusher/features/auth/data/models/user_model.dart';
import 'package:pusher/features/chat/domain/entities/message_entity.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.id,
    required super.content,
    required super.createdAt,
    required super.chatId,
    required super.user,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      content: json['message'],
      createdAt: json['created_at'],
      chatId: json['chat_id'],
      user: UserModel.fromJson(json['user']),
    );
  }
}
