import 'package:flutter/cupertino.dart';

/// Utility mapping metric ids/icons to consistent iconography and colors.
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

  static const _colorMap = <String, Color>{
    'readiness': Color(0xFF7C4DFF),
    'activity': Color(0xFFFF7043),
    'sleep': Color(0xFF42A5F5),
    'resting_hr': Color(0xFFE53935),
    'hrv': Color(0xFFEC407A),
    'active_points': Color(0xFF26C6DA),
    'steps': Color(0xFF66BB6A),
    'calories': Color(0xFFFFB300),
    'move_hours': Color(0xFF8D6E63),
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

  static Color colorFor(String? key, {String? fallbackKey}) {
    final normalized = key?.toLowerCase();
    if (normalized != null && _colorMap.containsKey(normalized)) {
      return _colorMap[normalized]!;
    }

    final normalizedFallback = fallbackKey?.toLowerCase();
    if (normalizedFallback != null && _colorMap.containsKey(normalizedFallback)) {
      return _colorMap[normalizedFallback]!;
    }

    return CupertinoColors.inactiveGray;
  }
}
