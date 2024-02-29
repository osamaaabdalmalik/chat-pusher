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
      name: json['participants'][0]['user']['username'],
      lastMessage: json['last_message'] != null ? json['last_message']['message'] : "",
      messageCreatedAt: json['created_at'],
    );
  }
}
