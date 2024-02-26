import 'package:dartz/dartz.dart';
import 'package:pusher/core/errors/failures.dart';
import 'package:pusher/features/main/domain/entities/pair_entity.dart';

abstract class QuranRepo {
  Future<Either<Failure, List<Pair>>> getCategoriesAsPair({required int repositoryId});
}
