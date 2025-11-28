import 'package:get_it/get_it.dart';

import '../data/data_sources/score_local_data_source.dart';
import '../data/repositories/score_repository_impl.dart';
import '../domain/repositories/score_repository.dart';
import '../domain/usecases/get_scores.dart';
import '../presentation/cubit/score_detail_cubit.dart';
import '../presentation/cubit/score_overview_cubit.dart';

Future<void> initScoresModule(GetIt sl) async {
  // Data sources
  sl.registerLazySingleton<ScoreLocalDataSource>(
    () => ScoreLocalDataSourceImpl(assetPath: 'assets/mock_data.json'),
  );

  // Repository
  sl.registerLazySingleton<ScoreRepository>(
    () => ScoreRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetScores(sl()));

  // Presentation
  sl.registerFactory(() => ScoreOverviewCubit(getScores: sl()));
  sl.registerFactory(
    () => ScoreDetailCubit(getScores: sl()),
  );
}
