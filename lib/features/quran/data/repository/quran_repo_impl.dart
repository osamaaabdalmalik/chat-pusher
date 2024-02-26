import 'package:dartz/dartz.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/core/helpers/get_failure_from_exception.dart';
import 'package:pusher/features/main/domain/entities/pair_entity.dart';
import 'package:pusher/features/quran/data/data_sources/quran_remote_data_source.dart';
import 'package:pusher/features/quran/domain/repository/quran_repo.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class QuranRepoImpl implements QuranRepo {
  final QuranRemoteDataSource quranRemoteDataSource;

  const QuranRepoImpl({required this.quranRemoteDataSource});

  @override
  Future<Either<Failure, List<Pair>>> getCategoriesAsPair({required int repositoryId}) async {
    try {
      Get.find<Logger>().i("Start `getCategoriesAsPair` in |QuranRepoImpl|");
      var pairModels = await quranRemoteDataSource.getCategoriesAsPair(repositoryId: repositoryId);
      Get.find<Logger>().f("End `getCategoriesAsPair` in |QuranRepoImpl|");
      return Right(pairModels);
    } catch (e) {
      Get.find<Logger>().e("End `getCategoriesAsPair` in |QuranRepoImpl| Exception: ${e.runtimeType}");
      return Left(getFailureFromException(e));
    }
  }
}
