import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/core/helpers/get_failure_from_exception.dart';
import 'package:pusher/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:pusher/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';
import 'package:pusher/features/auth/domain/entities/user_entity.dart';
import 'package:pusher/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  const AuthRepoImpl({required this.authRemoteDataSource, required this.authLocalDataSource});

  @override
  Future<Either<Failure, UserAuth>> register({required User user}) async {
    try {
      Get.find<Logger>().i("Start `register` in |AuthRepoImpl|");
      var userAuthModel = await authRemoteDataSource.register(userModel: user.toModel());
      await authLocalDataSource.setUser(userAuthModel: userAuthModel);
      Get.find<Logger>().f("End `register` in |AuthRepoImpl|");
      return Right(userAuthModel);
    } catch (e) {
      Get.find<Logger>().e("End `register` in |AuthRepoImpl| Exception: ${e.runtimeType}");
      return Left(getFailureFromException(e));
    }
  }
}
