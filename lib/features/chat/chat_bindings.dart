import 'package:get/get.dart';
import 'package:pusher/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:pusher/features/chat/data/repository/chat_repo_impl.dart';
import 'package:pusher/features/chat/domain/repository/chat_repo.dart';
import 'package:pusher/features/chat/presentation/controller/chat_controller.dart';

class ChatBindings extends Bindings {
  @override
  dependencies() async {
    Get.put<ChatRemoteDataSource>(
      ChatRemoteDataSourceImpl(apiService: Get.find()),
    );
    Get.put<ChatRepo>(
      ChatRepoImpl(chatRemoteDataSource: Get.find()),
    );

//    Get.put(GetCategoriesAsPairUseCase(Get.find()));
    Get.put(ChatController());
  }
}
