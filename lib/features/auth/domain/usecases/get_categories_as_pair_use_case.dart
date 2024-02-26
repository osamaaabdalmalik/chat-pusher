import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/main/domain/entities/pair_entity.dart';
import 'package:pusher/features/main/domain/repository/main_repo.dart';

class GetCategoriesAsPairUseCase {
  final MainRepo repo;

  GetCategoriesAsPairUseCase(this.repo);

  Future<Either<Failure, List<Pair>>> call({required int repositoryId}) async {
    Get.find<Logger>().i("Call GetCategoriesAsPairUseCase");
    return await repo.getCategoriesAsPair(repositoryId: repositoryId);
  }
}
