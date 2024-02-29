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
      Get.find<Logger>().w("End `register` in |AuthRepoImpl|");
      return Right(userAuthModel);
    } catch (e, s) {
      Get.find<Logger>().e("End `register` in |AuthRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, UserAuth>> login({required User user}) async {
    try {
      Get.find<Logger>().i("Start `login` in |AuthRepoImpl|");
      var userAuthModel = await authRemoteDataSource.login(userModel: user.toModel());
      await authLocalDataSource.setUser(userAuthModel: userAuthModel);
      Get.find<Logger>().w("End `login` in |AuthRepoImpl|");
      return Right(userAuthModel);
    } catch (e, s) {
      Get.find<Logger>().e("End `login` in |AuthRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      Get.find<Logger>().i("Start `logout` in |AuthRepoImpl|");
      await authRemoteDataSource.logout();
      await authLocalDataSource.clear();
      Get.find<Logger>().w("End `logout` in |AuthRepoImpl|");
      return const Right(unit);
    } catch (e, s) {
      Get.find<Logger>().e("End `logout` in |AuthRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }

  @override
  Future<Either<Failure, UserAuth?>> getUser() async {
    try {
      Get.find<Logger>().i("Start `getUser` in |AuthRepoImpl|");
      var userAuth = await authLocalDataSource.getUser();
      Get.find<Logger>().w("End `getUser` in |AuthRepoImpl|");
      return Right(userAuth);
    } catch (e, s) {
      Get.find<Logger>().e("End `getUser` in |AuthRepoImpl| Exception: ${e.runtimeType} $s");
      return Left(getFailureFromException(e));
    }
  }
}
