import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/score.dart';
import 'metric_icon_mapper.dart';

class MetricTile extends StatelessWidget {
  final Metric metric;

  const MetricTile({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    final color =
        metric.hasData
            ? AppTheme.getMetricColor(metric.value)
            : Theme.of(context).colorScheme.surfaceContainerHighest;
    final iconData = MetricIconMapper.iconFor(
      metric.icon,
      fallbackKey: metric.id,
    );
    final iconColor = metric.hasData ? color : CupertinoColors.inactiveGray;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CupertinoColors.systemGrey4),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(iconData, size: 22, color: iconColor),
                      const SizedBox(width: 6),
                      Text(
                        metric.title,
                        style: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    metric.displayValue,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _CupertinoProgress(
                value: metric.hasData ? metric.value / 100 : 0,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CupertinoProgress extends StatelessWidget {
  const _CupertinoProgress({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final safeValue = value.clamp(0.0, 1.0);
    return SizedBox(
      height: 5,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
          AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 250),
            widthFactor: safeValue,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
