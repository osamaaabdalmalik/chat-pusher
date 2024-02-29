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
import 'package:pusher/features/chat/domain/usecases/get_chats_use_case.dart';

class ChatController extends GetxController {
  // Data
  UserAuth? userAuth;
  Chat? currentChat;
  List<Chat> chats = [];

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
  StateType getChatsState = StateType.init;

  // Primitive
  String validationMessage = '';

  @override
  void onInit() async {
    Get.find<Logger>().i("Start onInit |ChatController|");
    super.onInit();
    userAuth = Get.arguments[AppKeys.user];
    await getChats();
    Get.find<Logger>().w("End onInit |ChatController|");
  }

  Future<bool> getChats() async {
    Get.find<Logger>().i("Start `getChats` in |ChatController|");
    getChatsState = StateType.loading;
    update();
    GetChatsUseCase getChatsUseCase = GetChatsUseCase(Get.find());
    var result = await getChatsUseCase();
    return result.fold(
      (l) async {
        getChatsState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        getChatsState = StateType.init;
        Get.find<Logger>().w("End `getChats` in |ChatController| $getChatsState");
        return false;
      },
      (r) {
        getChatsState = StateType.success;
        chats = r;
        update();
        Get.find<Logger>().w("End `getChats` in |ChatController| ${chats.length}");
        return true;
      },
    );
  }

  Future<bool> createChat() async {
    Get.find<Logger>().i("Start `createChat` in |ChatController|");
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
        Get.find<Logger>().w("End `createChat` in |ChatController| $createChatState");
        return false;
      },
      (r) {
        createChatState = StateType.success;
        currentChat = r;
        update();
        Get.toNamed(AppPagesRoutes.chatScreen);
        Get.find<Logger>().w("End `createChat` in |ChatController| $createChatState");
        return true;
      },
    );
  }
}
