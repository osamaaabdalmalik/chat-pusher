import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/chat/domain/repository/chat_repo.dart';

class CreateChatUseCase {
  final ChatRepo repo;

  CreateChatUseCase(this.repo);

  Future<Either<Failure, Unit>> call({required int userId}) async {
    Get.find<Logger>().i("Call CreateChatUseCase");
    return await repo.createChat(userId: userId);
  }
}
