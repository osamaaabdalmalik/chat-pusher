abstract class AppApiRoutes {
  static const String baseUrl = "10.0.2.2:8000"; // For Emulator

  static const String getCategoriesAsPair = "/category/get_categories_as_pair";
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String logout = "/auth/logout";

  static const String getChats = "/chat";
  static const String createChat = "/chat";
  static const String getMessages = "/chat_message";
  static const String createMessage = "/chat_message";
}
