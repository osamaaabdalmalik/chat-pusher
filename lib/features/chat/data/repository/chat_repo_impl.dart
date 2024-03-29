import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/core/helpers/get_failure_from_exception.dart';
import 'package:pusher/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:pusher/features/chat/domain/entities/chat_entity.dart';
import 'package:pusher/features/chat/domain/entities/message_entity.dart';
import 'package:pusher/features/chat/domain/repository/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDataSource chatRemoteDataSource;

  const ChatRepoImpl({required this.chatRemoteDataSource});

  @override
  Future<Either<Failure, List<Chat>>> getChats() async {
    try {
      Get.find<Logger>().i("Start `getChats` in |ChatRepoImpl|");
      var chats = await chatRemoteDataSource.getChats();
      Get.find<Logger>().w("End `getChats` in |ChatRepoImpl|");
      return Right(chats);
    } catch (e, s) {
      Get.find<Logger>().e("End `getChats` in |ChatRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, Chat>> createChat({required int userId}) async {
    try {
      Get.find<Logger>().i("Start `createChat` in |ChatRepoImpl|");
      var chat = await chatRemoteDataSource.createChat(userId: userId);
      Get.find<Logger>().w("End `createChat` in |ChatRepoImpl|");
      return Right(chat);
    } catch (e, s) {
      Get.find<Logger>().e("End `createChat` in |ChatRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required int chatId,
    required int page,
  }) async {
    try {
      Get.find<Logger>().i("Start `getMessages` in |ChatRepoImpl|");
      var messages = await chatRemoteDataSource.getMessages(chatId: chatId, page: page);
      Get.find<Logger>().w("End `getMessages` in |ChatRepoImpl|");
      return Right(messages);
    } catch (e, s) {
      Get.find<Logger>().e("End `getMessages` in |ChatRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, Message>> createMessage({
    required int chatId,
    required String messageContent,
  }) async {
    try {
      Get.find<Logger>().i("Start `createMessage` in |ChatRepoImpl|");
      var message = await chatRemoteDataSource.createMessage(chatId: chatId, messageContent: messageContent);
      Get.find<Logger>().w("End `createMessage` in |ChatRepoImpl|");
      return Right(message);
    } catch (e, s) {
      Get.find<Logger>().e("End `createMessage` in |ChatRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }
}
