import 'package:dartz/dartz.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/core/helpers/get_failure_from_exception.dart';
import 'package:pusher/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pusher/features/auth/domain/repository/auth_repo.dart';
import 'package:pusher/features/main/domain/entities/pair_entity.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  const AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, List<Pair>>> getCategoriesAsPair({required int repositoryId}) async {
    try {
      Get.find<Logger>().i("Start `getCategoriesAsPair` in |AuthRepoImpl|");
      var pairModels = await authRemoteDataSource.getCategoriesAsPair(repositoryId: repositoryId);
      Get.find<Logger>().f("End `getCategoriesAsPair` in |AuthRepoImpl|");
      return Right(pairModels);
    } catch (e) {
      Get.find<Logger>().e("End `getCategoriesAsPair` in |AuthRepoImpl| Exception: ${e.runtimeType}");
      return Left(getFailureFromException(e));
    }
  }
}
