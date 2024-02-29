import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_enums.dart';
import 'package:pusher/core/constants/app_keys.dart';
import 'package:pusher/core/constants/app_pages_routes.dart';
import 'package:pusher/core/helpers/get_state_from_failure.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';
import 'package:pusher/features/chat/domain/entities/chat_entity.dart';
import 'package:pusher/features/chat/domain/entities/message_entity.dart';
import 'package:pusher/features/chat/domain/usecases/create_chat_use_case.dart';
import 'package:pusher/features/chat/domain/usecases/create_message_use_case.dart';
import 'package:pusher/features/chat/domain/usecases/get_chats_use_case.dart';
import 'package:pusher/features/chat/domain/usecases/get_messages_use_case.dart';

class ChatController extends GetxController {
  // Data
  UserAuth? userAuth;
  Chat? currentChat;
  Message? currentMessage;
  List<Chat> chats = [];
  List<ChatMessage> chatMessages = [];

  // TODO Change
  ChatUser anotherUserChat = ChatUser(
    id: '2',
    firstName: 'Ammar',
    lastName: 'Al Alset',
  );

  // States
  StateType createChatState = StateType.init;
  StateType getChatsState = StateType.init;
  StateType getMessagesState = StateType.init;
  StateType createMessageState = StateType.init;

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
        Get.find<Logger>().w("End `getChats` in |ChatController| $getChatsState");
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

  Future<bool> getMessages({required int index}) async {
    Get.find<Logger>().i("Start `getMessages` in |ChatController|");
    currentChat = chats[index];
    getMessagesState = StateType.loading;
    update();
    GetMessagesUseCase getMessagesUseCase = GetMessagesUseCase(Get.find());
    var result = await getMessagesUseCase(
      chatId: currentChat!.id,
      page: 1,
    );
    return result.fold(
      (l) async {
        getMessagesState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        getMessagesState = StateType.init;
        Get.find<Logger>().w("End `getMessages` in |ChatController| $getMessagesState");
        return false;
      },
      (r) {
        getMessagesState = StateType.success;
        chatMessages.clear();
        for (var message in r) {
          chatMessages.add(
            ChatMessage(
              text: message.content,
              user: ChatUser(
                id: message.user.id.toString(),
                firstName: message.user.username,
              ),
              createdAt: DateTime.parse(message.createdAt),
            ),
          );
        }
        update();
        Get.toNamed(AppPagesRoutes.chatScreen);
        Get.find<Logger>().w("End `getMessages` in |ChatController| $getMessagesState");
        return true;
      },
    );
  }

  Future<bool> createMessage({required ChatMessage chatMessage}) async {
    Get.find<Logger>().i("Start `createMessage` in |ChatController|");
    createMessageState = StateType.loading;
    update();
    CreateMessageUseCase createMessageUseCase = CreateMessageUseCase(Get.find());
    var result = await createMessageUseCase(
      chatId: currentChat!.id,
      messageContent: chatMessage.text,
    );
    return result.fold(
      (l) async {
        createMessageState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        createMessageState = StateType.init;
        Get.find<Logger>().w("End `createMessage` in |ChatController| $createMessageState");
        return false;
      },
      (r) {
        createMessageState = StateType.success;
        currentMessage = r;
        update();
        chatMessages.insert(
          0,
          ChatMessage(
            text: currentMessage!.content,
            user: ChatUser(
              id: currentMessage!.user.id.toString(),
              firstName: currentMessage!.user.username,
            ),
            createdAt: DateTime.parse(currentMessage!.createdAt),
          ),
        );
        Get.find<Logger>().w("End `createMessage` in |ChatController| $createMessageState");
        return true;
      },
    );
  }
}
