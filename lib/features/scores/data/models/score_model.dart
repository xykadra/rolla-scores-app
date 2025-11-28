import '../../domain/entities/score.dart';
import '../../domain/entities/timeframe.dart';

class ScoreModel extends Score {
  const ScoreModel({
    required super.id,
    required super.title,
    required super.about,
    required super.timeframes,
    required super.metricInfo,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    final timeframesJson = json['timeframes'] as Map<String, dynamic>? ?? {};
    final metricInfoJson = json['metricInfo'] as List<dynamic>? ?? [];

    final timeframes = <Timeframe, ScoreTimeframeData>{};
    timeframesJson.forEach((key, value) {
      final timeframe = TimeframeX.fromKey(key);
      timeframes[timeframe] = ScoreTimeframeDataModel.fromJson(
        value as Map<String, dynamic>,
      );
    });

    final metricInfo =
        metricInfoJson
            .map(
              (info) =>
                  MetricDefinitionModel.fromJson(info as Map<String, dynamic>),
            )
            .toList();

    return ScoreModel(
      id: (json['id'] as int?) ?? 0,
      title: (json['title'] as String?) ?? 'Score',
      about: (json['about'] as String?) ?? '',
      timeframes: timeframes,
      metricInfo: metricInfo,
    );
  }
}

class MetricDefinitionModel extends MetricDefinition {
  const MetricDefinitionModel({
    required super.id,
    required super.title,
    required super.description,
    super.icon,
  });

  factory MetricDefinitionModel.fromJson(Map<String, dynamic> json) {
    return MetricDefinitionModel(
      id: (json['id'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      icon: (json['icon'] as String?) ?? '',
    );
  }
}

class MetricModel extends Metric {
  const MetricModel({
    required super.id,
    required super.title,
    required super.displayValue,
    required super.unit,
    required super.value,
    super.hasData,
    super.icon,
  });

  factory MetricModel.fromJson(Map<String, dynamic> json) {
    return MetricModel(
      id: (json['id'] as String?) ?? '',
      title: (json['title'] as String?) ?? '',
      displayValue: json['displayValue'] as String? ?? 'No data',
      unit: json['unit'] as String? ?? '',
      value: json['value'] as int? ?? 0,
      hasData: json['displayValue'] != null,
      icon: (json['icon'] as String?) ?? (json['id'] as String?) ?? '',
    );
  }
}

class ScoreTimeframeDataModel extends ScoreTimeframeData {
  const ScoreTimeframeDataModel({
    required super.score,
    required super.subtitle,
    required super.history,
    required super.metrics,
    required super.insights,
    super.averageLabel,
  });

  factory ScoreTimeframeDataModel.fromJson(Map<String, dynamic> json) {
    final historyJson = json['history'] as List<dynamic>? ?? [];
    final metricsJson = json['metrics'] as List<dynamic>? ?? [];
    final insightsJson = json['insights'] as List<dynamic>? ?? [];

    return ScoreTimeframeDataModel(
      score: json['score'] as int? ?? 0,
      subtitle: json['subtitle'] as String? ?? '',
      averageLabel: json['averageLabel'] as String?,
      history:
          historyJson
              .map(
                (item) => HistoryPoint(
                  label:
                      ((item as Map<String, dynamic>)['label'] as String?) ??
                      '',
                  value: (item)['value'] as int? ?? 0,
                ),
              )
              .toList(),
      metrics:
          metricsJson
              .map((item) => MetricModel.fromJson(item as Map<String, dynamic>))
              .toList(),
      insights: insightsJson.cast<String>(),
    );
  }
}
