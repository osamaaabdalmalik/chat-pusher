import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher/core/constants/app_colors.dart';
import 'package:pusher/core/widgets/handle_states_widget.dart';
import 'package:pusher/features/auth/presentation/controller/auth_controller.dart';
import 'package:pusher/features/chat/presentation/controller/chat_controller.dart';

class ChatsScreen extends GetView<ChatController> {
  const ChatsScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('All Chats'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Get.put(AuthController()).logout();
            },
          ),
        ],
      ),
      body: GetBuilder<ChatController>(
        builder: (controller) => HandleStatesWidget(
          stateType: controller.getChatsState,
          validationMessage: controller.validationMessage,
          child: ListView.builder(
            itemCount: controller.chats.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(
                Icons.account_circle,
                size: 50.0,
                color: AppColors.gray,
              ),
              title: Text(controller.chats[index].name),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.chats[index].lastMessage,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    controller.chats[index].messageCreatedAt.substring(0, 10),
                    style: const TextStyle(color: AppColors.gray),
                  ),
                ],
              ),
              onTap: () async {
                await controller.getMessages(index: index);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.createChat();
        },
        child: const Icon(Icons.add_comment_rounded),
      ),
    );
  }
}
