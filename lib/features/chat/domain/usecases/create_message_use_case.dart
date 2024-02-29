import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/chat/domain/entities/message_entity.dart';
import 'package:pusher/features/chat/domain/repository/chat_repo.dart';

class CreateMessageUseCase {
  final ChatRepo repo;

  CreateMessageUseCase(this.repo);

  Future<Either<Failure, Message>> call({
    required int chatId,
    required String messageContent,
  }) async {
    Get.find<Logger>().i("Call CreateMessageUseCase");
    return await repo.createMessage(chatId: chatId, messageContent: messageContent);
  }
}
