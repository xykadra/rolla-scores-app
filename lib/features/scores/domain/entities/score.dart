import 'package:equatable/equatable.dart';

import 'timeframe.dart';

class MetricDefinition extends Equatable {
  final String id;
  final String title;
  final String description;
  final String icon;

  const MetricDefinition({
    required this.id,
    required this.title,
    required this.description,
    this.icon = '',
  });

  @override
  List<Object?> get props => [id, title, description, icon];
}

class Metric extends Equatable {
  final String id;
  final String title;
  final String displayValue;
  final String unit;
  final int value;
  final bool hasData;
  final String icon;

  const Metric({
    required this.id,
    required this.title,
    required this.displayValue,
    required this.unit,
    required this.value,
    this.hasData = true,
    this.icon = '',
  });

  @override
  List<Object?> get props => [
    id,
    title,
    displayValue,
    unit,
    value,
    hasData,
    icon,
  ];
}

class ScoreTimeframeData extends Equatable {
  final int score;
  final String subtitle;
  final String? averageLabel;
  final List<HistoryPoint> history;
  final List<Metric> metrics;
  final List<String> insights;

  const ScoreTimeframeData({
    required this.score,
    required this.subtitle,
    this.averageLabel,
    required this.history,
    required this.metrics,
    required this.insights,
  });

  @override
  List<Object?> get props => [
    score,
    subtitle,
    averageLabel,
    history,
    metrics,
    insights,
  ];
}

class Score extends Equatable {
  final int id;
  final String title;
  final String about;
  final Map<Timeframe, ScoreTimeframeData> timeframes;
  final List<MetricDefinition> metricInfo;

  const Score({
    required this.id,
    required this.title,
    required this.about,
    required this.timeframes,
    required this.metricInfo,
  });

  ScoreTimeframeData? dataFor(Timeframe timeframe) => timeframes[timeframe];

  @override
  List<Object?> get props => [id, title, about, timeframes, metricInfo];
}
