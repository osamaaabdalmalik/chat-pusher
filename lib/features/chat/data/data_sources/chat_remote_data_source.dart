import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_api_routes.dart';
import 'package:pusher/core/services/api_service.dart';
import 'package:pusher/features/chat/data/models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();

  Future<Unit> createChat({required int userId});
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final ApiService apiService;

  ChatRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ChatModel>> getChats() async {
    try {
      Get.find<Logger>().i("Start `getChats` in |MainRemoteDataSourceImpl|");

      Map<String, dynamic> mapData = await apiService.get(
        subUrl: AppApiRoutes.getChats,
      );
      final List<ChatModel> chatsModels = mapData['data']
          .map<ChatModel>(
            (item) => ChatModel.fromJson(item),
          )
          .toList();

      Get.find<Logger>().w("End `getChats` in |MainRemoteDataSourceImpl|");
      return Future.value(chatsModels);
    } catch (e) {
      Get.find<Logger>().e(
        "End `getChats` in |MainRemoteDataSourceImpl| Exception: ${e.runtimeType}",
      );
      rethrow;
    }
  }

  @override
  Future<Unit> createChat({required int userId}) async {
    try {
      Get.find<Logger>().i("Start `createChat` in |MainRemoteDataSourceImpl|");

      await apiService.post(
        subUrl: AppApiRoutes.createChat,
        data: {
          'user_id': userId,
        },
      );
      Get.find<Logger>().w("End `createChat` in |MainRemoteDataSourceImpl|");
      return Future.value(unit);
    } catch (e) {
      Get.find<Logger>().e(
        "End `createChat` in |MainRemoteDataSourceImpl| Exception: ${e.runtimeType}",
      );
      rethrow;
    }
  }
}
