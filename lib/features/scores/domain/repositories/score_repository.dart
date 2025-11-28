import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/score.dart';

abstract class ScoreRepository {
  Future<Either<Failure, List<Score>>> getScores();
}
