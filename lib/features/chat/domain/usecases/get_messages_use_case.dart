import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/chat/domain/entities/message_entity.dart';
import 'package:pusher/features/chat/domain/repository/chat_repo.dart';

class GetMessagesUseCase {
  final ChatRepo repo;

  GetMessagesUseCase(this.repo);

  Future<Either<Failure, List<Message>>> call({
    required int chatId,
    required int page,
  }) async {
    Get.find<Logger>().i("Call GetMessagesUseCase");
    return await repo.getMessages(chatId: chatId, page: page);
  }
}
