import 'package:dartz/dartz.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/chat/domain/entities/chat_entity.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<Chat>>> getChats();

  Future<Either<Failure, Unit>> createChat({required int userId});
}
