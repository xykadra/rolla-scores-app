part of 'score_overview_cubit.dart';

class ScoreOverviewState extends Equatable {
  final bool isLoading;
  final List<Score> scores;
  final String? error;

  const ScoreOverviewState._({
    required this.isLoading,
    required this.scores,
    this.error,
  });

  const ScoreOverviewState.initial()
      : this._(isLoading: false, scores: const []);

  const ScoreOverviewState.loading()
      : this._(isLoading: true, scores: const []);

  const ScoreOverviewState.loaded(List<Score> scores)
      : this._(isLoading: false, scores: scores);

  const ScoreOverviewState.error(String message)
      : this._(isLoading: false, scores: const [], error: message);

  @override
  List<Object?> get props => [isLoading, scores, error];
}
