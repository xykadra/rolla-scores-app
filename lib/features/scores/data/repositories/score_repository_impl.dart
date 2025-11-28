import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/score.dart';
import '../../domain/repositories/score_repository.dart';
import '../data_sources/score_local_data_source.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final ScoreLocalDataSource localDataSource;

  ScoreRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Score>>> getScores() async {
    try {
      final scores = await localDataSource.loadScores();
      return Right(scores);
    } on FormatException catch (error) {
      return Left(DataParsingFailure(error.message));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
