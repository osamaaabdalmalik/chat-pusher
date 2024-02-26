
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ChatController extends GetxController{

  ChatUser user = ChatUser(
    id: '2',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Hey!',
      user: ChatUser(
        id: '1',
        firstName: 'Charles',
        lastName: 'Leclerc',
      ),
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      text: 'Hey!',
      user: ChatUser(
        id: '2',
        firstName: 'Charles 2',
        lastName: 'Leclerc',
      ),
      createdAt: DateTime.now(),
    ),
  ];

  @override
  void onInit() {
    Get.find<Logger>().i("Start onInit ChatController");
    super.onInit();
    Get.find<Logger>().f("End onInit ChatController");
  }

}