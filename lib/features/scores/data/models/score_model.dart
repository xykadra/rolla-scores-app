import '../../domain/entities/score.dart';
import '../../domain/entities/timeframe.dart';

class ScoreModel extends Score {
  const ScoreModel({
    required super.id,
    required super.title,
    required super.about,
    required super.accentColor,
    required super.timeframes,
  });

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    final timeframesJson = json['timeframes'] as Map<String, dynamic>? ?? {};

    final timeframes = <Timeframe, ScoreTimeframeData>{};
    timeframesJson.forEach((key, value) {
      final timeframe = TimeframeX.fromKey(key);
      timeframes[timeframe] = ScoreTimeframeDataModel.fromJson(
        value as Map<String, dynamic>,
      );
    });

    return ScoreModel(
      id: (json['id'] as int?) ?? 0,
      title: (json['title'] as String?) ?? 'Score',
      about: (json['about'] as String?) ?? '',
      timeframes: timeframes,
      accentColor: _parseColor(json['color'] as String?),
    );
  }

  static int _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return 0xFF4CAF50;
    var value = hex.replaceAll('#', '');
    if (value.length == 6) value = 'FF$value';
    return int.tryParse(value, radix: 16) ?? 0xFF4CAF50;
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
    required super.showProgress,
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
      showProgress: json['showProgress'] as bool? ?? false,
    );
  }
}

class ScoreTimeframeDataModel extends ScoreTimeframeData {
  const ScoreTimeframeDataModel({
    required super.score,
    required super.date,
    required super.history,
    required super.mainMetrics,
    required super.infoMetrics,
    required super.insights,
    super.averageLabel,
  });

  factory ScoreTimeframeDataModel.fromJson(Map<String, dynamic> json) {
    final historyJson = json['history'] as List<dynamic>? ?? [];
    final mainMetricsJson = json['mainMetrics'] as List<dynamic>? ?? [];
    final infoMetricsJson = json['infoMetrics'] as List<dynamic>? ?? [];
    final insightsRaw = json['insights'];

    return ScoreTimeframeDataModel(
      score: json['score'] as int? ?? 0,
      date: (json['date'] as String?) ?? (json['subtitle'] as String?) ?? '',
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
      mainMetrics:
          mainMetricsJson
              .map((item) => MetricModel.fromJson(item as Map<String, dynamic>))
              .toList(),
      infoMetrics:
          infoMetricsJson
              .map((item) => MetricModel.fromJson(item as Map<String, dynamic>))
              .toList(),
      insights: () {
        if (insightsRaw is List && insightsRaw.isNotEmpty) {
          return insightsRaw.first as String? ?? '';
        }
        if (insightsRaw is String) return insightsRaw;
        return '';
      }(),
    );
  }
}
