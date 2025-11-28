import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/score.dart';
import '../repositories/score_repository.dart';

class GetScores {
  final ScoreRepository repository;

  GetScores(this.repository);

  Future<Either<Failure, List<Score>>> call() {
    return repository.getScores();
  }
}
