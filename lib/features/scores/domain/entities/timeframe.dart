import 'package:equatable/equatable.dart';

enum Timeframe {
  oneDay,
  sevenDays,
  thirtyDays,
  oneYear,
}

extension TimeframeX on Timeframe {
  String get label {
    switch (this) {
      case Timeframe.oneDay:
        return '1D';
      case Timeframe.sevenDays:
        return '7D';
      case Timeframe.thirtyDays:
        return '30D';
      case Timeframe.oneYear:
        return '1Y';
    }
  }

  static Timeframe fromKey(String key) {
    switch (key.toUpperCase()) {
      case '1D':
        return Timeframe.oneDay;
      case '7D':
        return Timeframe.sevenDays;
      case '30D':
        return Timeframe.thirtyDays;
      case '1Y':
        return Timeframe.oneYear;
      default:
        throw ArgumentError('Unknown timeframe key: $key');
    }
  }
}

class HistoryPoint extends Equatable {
  final String label;
  final int value;

  const HistoryPoint({required this.label, required this.value});

  @override
  List<Object?> get props => [label, value];
}
