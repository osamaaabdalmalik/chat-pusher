import 'package:dartz/dartz.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';
import 'package:pusher/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserAuth>> register({required User user});

  Future<Either<Failure, UserAuth>> login({required User user});

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, UserAuth?>> getUser();
}
