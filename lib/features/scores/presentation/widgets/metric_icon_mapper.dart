import 'package:flutter/cupertino.dart';

class MetricIconMapper {
  static const _iconMap = <String, IconData>{
    'readiness': CupertinoIcons.bolt_fill,
    'bolt': CupertinoIcons.bolt_fill,
    'activity': CupertinoIcons.flame_fill,
    'flame': CupertinoIcons.flame_fill,
    'sleep': CupertinoIcons.moon_stars_fill,
    'moon': CupertinoIcons.moon_stars_fill,
    'resting_hr': CupertinoIcons.heart_fill,
    'heart': CupertinoIcons.heart_fill,
    'hrv': CupertinoIcons.waveform_path_ecg,
    'waveform': CupertinoIcons.waveform_path_ecg,
    'active_points': CupertinoIcons.sparkles,
    'sparkles': CupertinoIcons.sparkles,
    'steps': CupertinoIcons.chart_bar,
    'walk': CupertinoIcons.chart_bar,
    'calories': CupertinoIcons.flame,
    'flame_outline': CupertinoIcons.flame,
    'move_hours': CupertinoIcons.clock,
    'clock': CupertinoIcons.clock,
  };

  static IconData iconFor(String? key, {String? fallbackKey}) {
    final normalized = key?.toLowerCase();
    if (normalized != null && _iconMap.containsKey(normalized)) {
      return _iconMap[normalized]!;
    }

    final normalizedFallback = fallbackKey?.toLowerCase();
    if (normalizedFallback != null && _iconMap.containsKey(normalizedFallback)) {
      return _iconMap[normalizedFallback]!;
    }

    return CupertinoIcons.circle;
  }
}
