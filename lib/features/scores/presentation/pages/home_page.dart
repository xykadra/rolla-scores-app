import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/loading_skeleton.dart';
import '../../domain/entities/timeframe.dart';
import '../../domain/entities/score.dart';
import '../cubit/score_detail_cubit.dart';
import '../cubit/score_overview_cubit.dart';
import '../widgets/score_card.dart';
import 'score_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Scores'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ScoreOverviewCubit, ScoreOverviewState>(
            builder: (context, state) {
              if (state.isLoading) {
                return _buildSkeletonList();
              }
              if (state.error != null) {
                return Center(child: Text(state.error!));
              }
              return CupertinoScrollbar(
                child: ListView.builder(
                  itemCount: state.scores.length,
                  itemBuilder: (context, index) {
                    final score = state.scores[index];
                    return ScoreCard(
                      score: score,
                      timeframe: Timeframe.oneDay,
                      onTap: () => _openDetail(score),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonList() {
    return CupertinoScrollbar(
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, _) => Container(
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).barBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(width: 120),
                SizedBox(height: 12),
                LoadingSkeleton(height: 12),
                SizedBox(height: 8),
                LoadingSkeleton(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openDetail(Score score) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) {
          return BlocProvider(
            create: (_) => sl<ScoreDetailCubit>()..load(score.id),
            child: ScoreDetailPage(score: score),
          );
        },
      ),
    );
  }
}
