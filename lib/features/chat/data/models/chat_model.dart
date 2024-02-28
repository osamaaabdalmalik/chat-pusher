import 'package:pusher/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.name,
    required super.lastMessage,
    required super.messageCreatedAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['last_message']['user']['username'],
      lastMessage: json['last_message']['message'],
      messageCreatedAt: json['last_message']['created_at'],
    );
  }
}
