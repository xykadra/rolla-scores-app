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
  final String date;
  final String? averageLabel;
  final List<HistoryPoint> history;
  final List<Metric> mainMetrics;
  final List<Metric> infoMetrics;
  final List<String> insights;

  const ScoreTimeframeData({
    required this.score,
    required this.date,
    this.averageLabel,
    required this.history,
    required this.mainMetrics,
    required this.infoMetrics,
    required this.insights,
  });

  @override
  List<Object?> get props => [
    score,
    date,
    averageLabel,
    history,
    mainMetrics,
    infoMetrics,
    insights,
  ];
}

class Score extends Equatable {
  final int id;
  final String title;
  final String about;
  final int accentColor;
  final Map<Timeframe, ScoreTimeframeData> timeframes;

  const Score({
    required this.id,
    required this.title,
    required this.about,
    required this.accentColor,
    required this.timeframes,
  });

  ScoreTimeframeData? dataFor(Timeframe timeframe) => timeframes[timeframe];

  @override
  List<Object?> get props => [
    id,
    title,
    about,
    accentColor,
    timeframes,
  ];
}
