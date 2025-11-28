# Rolla Scores App

Flutter demo that recreates the Rolla score detail experience with clean, feature-first architecture and local JSON data.

## Architecture
- **Feature-first + Clean Architecture:** `lib/features/scores/{data,domain,presentation}`.
- **Domain:** Entities + repository abstractions using `Either<Failure, T>`.
- **Data:** Local JSON data source (`assets/mock_data.json`) → models → repository.
- **Presentation:** `flutter_bloc` cubits (`ScoreOverviewCubit`, `ScoreDetailCubit`) with reusable widgets (cards, gauge, charts, metric tiles).
- **DI:** `get_it` in `lib/core/di/injection.dart` and `lib/features/scores/di/scores_injection.dart`.
- **UI:** Google Outfit font, light/dark themes, charts via `fl_chart`, custom radial gauge for 1D view.

## Setup
```bash
flutter pub get
flutter run
```

## Notes
- Data is simulated from `assets/mock_data.json` to cover 1D/7D/30D/1Y ranges for Health, Readiness, and Activity.
- Timeframe switching updates gauge/chart, metrics, and insights. Pull-to-refresh re-reads local data.
- Metric info/definitions live in the info drawer; metrics use conditional coloring (neutral/blue/green).
- Loading/error states are surfaced on both the home and detail flows.
