import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/score.dart';
import '../../domain/entities/timeframe.dart';

class ScoreCard extends StatelessWidget {
  final Score score;
  final Timeframe timeframe;
  final VoidCallback? onTap;

  const ScoreCard({
    super.key,
    required this.score,
    required this.timeframe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final data = score.dataFor(timeframe);
    final progress = (data?.score ?? 0) / 100;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).barBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _ScoreProgressCircle(
              value: data?.score ?? 0,
              progress: progress,
              color: Color(score.accentColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    score.title,
                    style: CupertinoTheme.of(context).textTheme.textStyle
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoTheme.of(
                context,
              ).textTheme.textStyle.color?.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreProgressCircle extends StatelessWidget {
  const _ScoreProgressCircle({
    required this.value,
    required this.progress,
    required this.color,
  });

  final int value;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 6,
            backgroundColor: color.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeCap: StrokeCap.round,
          ),
        ),
        Text(
          '$value',
          style: CupertinoTheme.of(
            context,
          ).textTheme.textStyle.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
