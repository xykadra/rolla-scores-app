import 'package:get_it/get_it.dart';

import '../../features/scores/di/scores_injection.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await initScoresModule(sl);
}
