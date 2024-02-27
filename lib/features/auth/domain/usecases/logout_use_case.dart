import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/auth/domain/repository/auth_repo.dart';

class LogoutUseCase {
  final AuthRepo repo;

  LogoutUseCase(this.repo);

  Future<Either<Failure, Unit>> call() async {
    Get.find<Logger>().i("Call LogoutUseCase");
    return await repo.logout();
  }
}
