import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/score.dart';
import '../../domain/entities/timeframe.dart';
import '../../domain/usecases/get_scores.dart';

part 'score_detail_state.dart';

class ScoreDetailCubit extends Cubit<ScoreDetailState> {
  ScoreDetailCubit({required this.getScores})
      : super(
          ScoreDetailState(
            timeframe: Timeframe.oneDay,
            status: ScoreDetailStatus.initial,
          ),
        );

  final GetScores getScores;

  Future<void> load(int id) async {
    emit(state.copyWith(status: ScoreDetailStatus.loading, error: null));
    final result = await getScores();
    result.fold(
      (failure) => emit(
        state.copyWith(status: ScoreDetailStatus.error, error: failure.message),
      ),
      (scores) {
        try {
          final score = scores.firstWhere((item) => item.id == id);
          emit(
            state.copyWith(
              status: ScoreDetailStatus.loaded,
              score: score,
            ),
          );
        } catch (_) {
          emit(
            state.copyWith(
              status: ScoreDetailStatus.error,
              error: 'Score not found',
            ),
          );
        }
      },
    );
  }

  void changeTimeframe(Timeframe timeframe) {
    emit(state.copyWith(timeframe: timeframe));
  }

  Future<void> refresh() async {
    if (state.score == null) return;
    await load(state.score!.id);
  }
}
