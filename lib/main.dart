import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolla_scores_app/core/theme/app_theme.dart';

import 'core/di/injection.dart';
import 'features/scores/presentation/cubit/score_overview_cubit.dart';
import 'features/scores/presentation/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const RollaScoresApp());
}

class RollaScoresApp extends StatelessWidget {
  const RollaScoresApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ScoreOverviewCubit>()..load()),
      ],
      child: CupertinoApp(
        title: 'Rolla Scores',
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US')],
        home: const HomePage(),
        theme: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? AppTheme.darkTheme()
            : AppTheme.lightTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
