import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher/features/chat/presentation/controller/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.currentChat!.name),
      ),
      body: GetBuilder<ChatController>(
        builder: (controller) => DashChat(
          currentUser: ChatUser(
            id: controller.userAuth!.user.id.toString(),
            firstName: controller.userAuth!.user.username,
          ),
          onSend: (ChatMessage m) async {
            await controller.createMessage(chatMessage: m);
          },
          messages: controller.chatMessages,
          typingUsers: [controller.anotherUserChat],
          quickReplyOptions: QuickReplyOptions(
            onTapQuickReply: (QuickReply r) {
              final ChatMessage m = ChatMessage(
                user: controller.anotherUserChat,
                text: r.value ?? r.title,
                createdAt: DateTime.now(),
              );
              controller.chatMessages.insert(0, m);
              controller.update();
            },
          ),
          inputOptions: const InputOptions(
            sendOnEnter: true,
          ),
          messageListOptions: MessageListOptions(
            onLoadEarlier: () async {
              await Future.delayed(const Duration(seconds: 3));
            },
          ),
        ),
      ),
    );
  }
}
