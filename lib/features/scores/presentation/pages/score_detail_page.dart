import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_skeleton.dart';
import '../../domain/entities/score.dart';
import '../../domain/entities/timeframe.dart';
import '../cubit/score_detail_cubit.dart';
import 'score_info_sheet.dart';
import '../widgets/metric_tile.dart';
import '../widgets/score_gauge.dart';
import '../widgets/score_history_chart.dart';
import '../widgets/timeframe_selector.dart';

class ScoreDetailPage extends StatefulWidget {
  final Score score;

  const ScoreDetailPage({super.key, required this.score});

  @override
  State<ScoreDetailPage> createState() => _ScoreDetailPageState();
}

class _ScoreDetailPageState extends State<ScoreDetailPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.all(0),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Icon(
            CupertinoIcons.back,
            size: 32,
            color: CupertinoColors.systemGrey2,
          ),
        ),
        middle: Text(widget.score.title),
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromRGBO(239, 239, 245, 1),
              Color.fromRGBO(255, 255, 255, 1), // TODO: Adjust for dark more
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<ScoreDetailCubit, ScoreDetailState>(
            builder: (context, state) {
              switch (state.status) {
                case ScoreDetailStatus.initial:
                case ScoreDetailStatus.loading:
                  return const Center(
                    child: LoadingSkeleton(height: 120, width: 120),
                  );
                case ScoreDetailStatus.error:
                  return Center(
                    child: Text(state.error ?? 'Something went wrong'),
                  );
                case ScoreDetailStatus.loaded:
                  return _buildContent(context, state);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ScoreDetailState state) {
    final score = state.score!;
    final data = score.dataFor(state.timeframe);
    final filteredMetrics = _filterMetricsForScore(score, data?.mainMetrics ?? []);
    final accentColor = Color(score.accentColor);
    final title =
        state.timeframe == Timeframe.sevenDays ? 'History' : '${score.title} Score';

    if (data == null) {
      return const Center(child: Text('No data for timeframe.'));
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () => context.read<ScoreDetailCubit>().refresh(),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              TimeframeSelector(
                selected: state.timeframe,
                onChanged: context.read<ScoreDetailCubit>().changeTimeframe,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      state.timeframe != Timeframe.sevenDays
                          ? CupertinoButton(
                            minimumSize: Size(0, 0),
                            padding: EdgeInsets.zero,
                            onPressed:
                                () => _openInfoSheet(
                                  context: context,
                                  score: score,
                                  data: data,
                                  timeframe: state.timeframe,
                                ),
                            child: Icon(
                              CupertinoIcons.question_circle_fill,
                              color: CupertinoColors.systemGrey,
                              size: 18,
                            ),
                          )
                          : SizedBox(),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.chevron_back,
                        size: 18,
                        color: CupertinoColors.systemGrey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        data.date,
                        style: CupertinoTheme.of(
                          context,
                        ).textTheme.textStyle.copyWith(color: Colors.grey),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        CupertinoIcons.chevron_forward,
                        size: 18,
                        color: CupertinoColors.systemGrey4,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (state.timeframe == Timeframe.oneDay)
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: ScoreGauge(score: data.score, color: accentColor),
                )
              else if (data.history.isNotEmpty)
                ScoreHistoryChart(
                  values:
                      data.history
                          .map((item) => item.value.toDouble())
                          .toList(),
                  labels: data.history.map((item) => item.label).toList(),
                  color: accentColor,
                  timeframe: state.timeframe,
                )
              else
                Container(
                  height: 160,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('No history for this range'),
                ),
              const SizedBox(height: 24),
              _SectionTitle(
                title: 'Metrics',
                trailing: data.averageLabel ?? '',
              ),
              const SizedBox(height: 8),
              Column(
                children:
                    filteredMetrics
                        .map((metric) => MetricTile(metric: metric))
                        .toList(),
              ),
              const SizedBox(height: 16),
              _SectionTitle(title: 'About'),
              const SizedBox(height: 8),
              Text(
                score.about,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  void _openInfoSheet({
    required BuildContext context,
    required Score score,
    required ScoreTimeframeData data,
    required Timeframe timeframe,
  }) {
    Navigator.of(context).push(
      CupertinoSheetRoute<void>(
        builder:
            (BuildContext context) => ScoreInfoSheet(
              score: score,
              data: data,
              timeframe: timeframe,
              metrics: _filterMetricsForScore(score, data.infoMetrics),
              accentColor: Color(score.accentColor),
            ),
      ),
    );
  }

  List<Metric> _filterMetricsForScore(Score score, List<Metric> metrics) {
    const groups = {
      'activity': ['active_points', 'steps', 'calories', 'move_hours'],
      'readiness': ['sleep', 'resting_hr', 'hrv'],
      'health score': ['readiness', 'activity'],
    };

    final key = score.title.toLowerCase();
    final allowed = groups[key];
    if (allowed == null) return metrics;

    final allowedSet = allowed.toSet();
    final filtered =
        metrics.where((metric) => allowedSet.contains(metric.id)).toList();

    return filtered.isNotEmpty ? filtered : metrics;
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? trailing;

  const _SectionTitle({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        if (trailing != null && trailing!.isNotEmpty)
          Text(
            trailing!,
            style: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.copyWith(fontSize: 13, color: Colors.grey),
          ),
      ],
    );
  }
}
