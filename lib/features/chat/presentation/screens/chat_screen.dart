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
        title: const Text('Basic example'),
      ),
      body: GetBuilder<ChatController>(
        builder: (controller) => DashChat(
          currentUser: controller.user,
          onSend: (ChatMessage m) {
            controller.messages.insert(0, m);
            controller.update();
          },
          messages: controller.messages,
          typingUsers: [controller.user],
          quickReplyOptions: QuickReplyOptions(
            onTapQuickReply: (QuickReply r) {
              final ChatMessage m = ChatMessage(
                user: controller.user,
                text: r.value ?? r.title,
                createdAt: DateTime.now(),
              );
              controller.messages.insert(0, m);
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
