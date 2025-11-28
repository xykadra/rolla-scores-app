part of 'score_detail_cubit.dart';

enum ScoreDetailStatus { initial, loading, loaded, error }

class ScoreDetailState extends Equatable {
  final ScoreDetailStatus status;
  final Score? score;
  final Timeframe timeframe;
  final String? error;

  const ScoreDetailState({
    required this.status,
    required this.timeframe,
    this.score,
    this.error,
  });

  ScoreDetailState copyWith({
    ScoreDetailStatus? status,
    Score? score,
    Timeframe? timeframe,
    String? error,
  }) {
    return ScoreDetailState(
      status: status ?? this.status,
      score: score ?? this.score,
      timeframe: timeframe ?? this.timeframe,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, score, timeframe, error];
}
