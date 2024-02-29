import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_enums.dart';
import 'package:pusher/core/constants/app_keys.dart';
import 'package:pusher/core/constants/app_pages_routes.dart';
import 'package:pusher/core/helpers/get_state_from_failure.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';
import 'package:pusher/features/chat/domain/entities/chat_entity.dart';
import 'package:pusher/features/chat/domain/usecases/create_chat_use_case.dart';

class ChatController extends GetxController {
  // Data
  UserAuth? userAuth;
  Chat? currentChat;

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

  // States
  StateType createChatState = StateType.init;

  // Primitive
  String validationMessage = '';

  @override
  void onInit() {
    Get.find<Logger>().i("Start onInit ChatController");
    super.onInit();
    userAuth = Get.arguments[AppKeys.user];
    Get.find<Logger>().w("End onInit ChatController ${userAuth?.user.username}");
  }

  Future<bool> createChat() async {
    Get.find<Logger>().i("Start `createChat` in |QuranController|");
    createChatState = StateType.loading;
    update();
    CreateChatUseCase createChatUseCase = CreateChatUseCase(Get.find());
    var result = await createChatUseCase(userId: 1); // TODO Change
    return result.fold(
      (l) async {
        createChatState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        createChatState = StateType.init;
        Get.find<Logger>().w("End `createChat` in |QuranController| $createChatState");
        return false;
      },
      (r) {
        createChatState = StateType.success;
        currentChat = r;
        update();
        Get.toNamed(AppPagesRoutes.chatScreen);
        Get.find<Logger>().w("End `createChat` in |QuranController| $createChatState");
        return true;
      },
    );
  }
}
