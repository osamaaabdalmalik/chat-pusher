import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/core/helpers/get_failure_from_exception.dart';
import 'package:pusher/features/main/data/data_sources/main_remote_data_source.dart';
import 'package:pusher/features/main/domain/entities/pair_entity.dart';
import 'package:pusher/features/main/domain/repository/main_repo.dart';

class MainRepoImpl implements MainRepo {
  final MainRemoteDataSource mainRemoteDataSource;

  const MainRepoImpl({required this.mainRemoteDataSource});

  @override
  Future<Either<Failure, List<Pair>>> getCategoriesAsPair({required int repositoryId}) async {
    try {
      Get.find<Logger>().i("Start `getCategoriesAsPair` in |MainRepoImpl|");
      var pairModels = await mainRemoteDataSource.getCategoriesAsPair(repositoryId: repositoryId);
      Get.find<Logger>().w("End `getCategoriesAsPair` in |MainRepoImpl|");
      return Right(pairModels);
    } catch (e, s) {
      Get.find<Logger>().e("End `getCategoriesAsPair` in |MainRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }

}
