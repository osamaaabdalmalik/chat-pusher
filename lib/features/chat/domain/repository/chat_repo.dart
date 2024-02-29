import 'package:dartz/dartz.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/chat/domain/entities/chat_entity.dart';
import 'package:pusher/features/chat/domain/entities/message_entity.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<Chat>>> getChats();

  Future<Either<Failure, Chat>> createChat({required int userId});

  Future<Either<Failure, List<Message>>> getMessages({
    required int chatId,
    required int page,
  });

  Future<Either<Failure, Message>> createMessage({
    required int chatId,
    required String messageContent,
  });
}
