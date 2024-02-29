import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/chat/domain/entities/chat_entity.dart';
import 'package:pusher/features/chat/domain/repository/chat_repo.dart';

class GetChatsUseCase {
  final ChatRepo repo;

  GetChatsUseCase(this.repo);

  Future<Either<Failure, List<Chat>>> call() async {
    Get.find<Logger>().i("Call GetChatsUseCase");
    return await repo.getChats();
  }
}
