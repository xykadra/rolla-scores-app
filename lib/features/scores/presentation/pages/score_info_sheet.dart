import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/score.dart';
import '../../domain/entities/timeframe.dart';
import '../widgets/metric_icon_mapper.dart';
import '../widgets/score_gauge.dart';

class ScoreInfoSheet extends StatelessWidget {
  final Score score;
  final ScoreTimeframeData data;
  final Timeframe timeframe;
  final List<Metric> metrics;
  final Color accentColor;

  const ScoreInfoSheet({
    super.key,
    required this.score,
    required this.data,
    required this.timeframe,
    required this.metrics,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = CupertinoTheme.of(context).textTheme.textStyle;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${score.title} Score',
                      style: textTheme.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CupertinoButton(
                    minimumSize: Size(0, 0),
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Icon(
                      CupertinoIcons.xmark,
                      size: 20,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(child: ScoreGauge(score: data.score, color: accentColor)),
              const SizedBox(height: 18),
              Text(
                'Metrics',
                style: textTheme.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).barBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < metrics.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              metrics[i].title,
                              style: textTheme.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              MetricIconMapper.iconFor(
                                metrics[i].icon,
                                fallbackKey: metrics[i].id,
                              ),
                              size: 20,
                              color: MetricIconMapper.colorFor(
                                metrics[i].icon,
                                fallbackKey: metrics[i].id,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              metrics[i].displayValue,
                              style: textTheme.copyWith(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.star_fill,
                                  size: 18,
                                  color: Colors.black87,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  metrics[i].value.toString(),
                                  style: textTheme.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (i != metrics.length - 1)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: CupertinoColors.systemGrey4,
                        ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'How It Works?',
                style: textTheme.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                score.about,
                style: textTheme.copyWith(fontSize: 15, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
