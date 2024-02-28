import 'package:get/get.dart';
import 'package:pusher/features/auth/auth_bindings.dart';
import 'package:pusher/features/auth/presentation/screens/auth_screen.dart';
import 'package:pusher/features/chat/chat_bindings.dart';
import 'package:pusher/features/chat/presentation/screens/chat_screen.dart';
import 'package:pusher/features/chat/presentation/screens/chats_screen.dart';
import 'package:pusher/features/main/main_bindings.dart';
import 'package:pusher/features/main/presentation/screens/main_screen.dart';

abstract class AppPagesRoutes {
  // Tabs Screens
  static const String mainScreen = "/mainScreen";
  static const String authScreen = "/";
  static const String chatScreen = "/chatScreen";
  static const String chatsScreen = "/chatsScreen";

  static List<GetPage<dynamic>> appPages = [
    GetPage(
      name: mainScreen,
      page: () => const MainScreen(),
      binding: MainBindings(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: authScreen,
      page: () => const AuthScreen(),
      binding: AuthBindings(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: chatScreen,
      page: () => const ChatScreen(),
      binding: ChatBindings(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: chatsScreen,
      page: () => const ChatsScreen(),
      binding: ChatBindings(),
      transition: Transition.leftToRight,
    ),
  ];
}
