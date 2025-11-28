import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/score.dart';
import '../../domain/usecases/get_scores.dart';

part 'score_overview_state.dart';

class ScoreOverviewCubit extends Cubit<ScoreOverviewState> {
  ScoreOverviewCubit({required this.getScores})
      : super(const ScoreOverviewState.initial());

  final GetScores getScores;

  Future<void> load() async {
    emit(const ScoreOverviewState.loading());
    final result = await getScores();
    result.fold(
      (failure) => emit(ScoreOverviewState.error(failure.message)),
      (scores) => emit(ScoreOverviewState.loaded(scores)),
    );
  }
}
