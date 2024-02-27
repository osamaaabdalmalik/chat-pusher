import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/core/helpers/get_failure_from_exception.dart';
import 'package:pusher/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:pusher/features/chat/domain/repository/chat_repo.dart';
import 'package:pusher/features/main/domain/entities/pair_entity.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatRemoteDataSource chatRemoteDataSource;

  const ChatRepoImpl({required this.chatRemoteDataSource});

  @override
  Future<Either<Failure, List<Pair>>> getCategoriesAsPair({required int repositoryId}) async {
    try {
      Get.find<Logger>().i("Start `getCategoriesAsPair` in |ChatRepoImpl|");
      var pairModels = await chatRemoteDataSource.getCategoriesAsPair(repositoryId: repositoryId);
      Get.find<Logger>().w("End `getCategoriesAsPair` in |ChatRepoImpl|");
      return Right(pairModels);
    } catch (e) {
      Get.find<Logger>().e("End `getCategoriesAsPair` in |ChatRepoImpl| Exception: ${e.runtimeType}");
      return Left(getFailureFromException(e));
    }
  }
}
