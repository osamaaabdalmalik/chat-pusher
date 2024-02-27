import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';
import 'package:pusher/features/auth/domain/entities/user_entity.dart';
import 'package:pusher/features/auth/domain/repository/auth_repo.dart';

class RegisterUseCase {
  final AuthRepo repo;

  RegisterUseCase(this.repo);

  Future<Either<Failure, UserAuth>> call({required User user}) async {
    Get.find<Logger>().i("Call RegisterUseCase");
    return await repo.register(user: user);
  }
}
