import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/timeframe.dart';

class ScoreHistoryChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final Color color;
  final Timeframe timeframe;

  const ScoreHistoryChart({
    super.key,
    required this.values,
    required this.labels,
    required this.color,
    required this.timeframe,
  });

  @override
  Widget build(BuildContext context) {
    final isYear =
        timeframe == Timeframe.oneYear || timeframe == Timeframe.thirtyDays;
    const gridInterval = 25.0;
    const gridStops = [0.0, 25.0, 50.0, 75.0, 100.0];

    return SizedBox(
      height: 162,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: 100,
          gridData: const FlGridData(show: false),
          extraLinesData: ExtraLinesData(
            horizontalLines: gridStops
                .map(
                  (stop) => HorizontalLine(
                    y: stop,
                    color: Colors.grey.withValues(alpha: 0.25),
                    strokeWidth: 1.5,
                  ),
                )
                .toList(),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: gridInterval,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      value.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= labels.length) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      labels[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups:
              values
                  .asMap()
                  .entries
                  .map(
                    (entry) => BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          width: isYear ? 26 : 8,
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ],
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
