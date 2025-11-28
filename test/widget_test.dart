// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:rolla_scores_app/main.dart';
import 'package:rolla_scores_app/core/di/injection.dart';

void main() {
  testWidgets('App renders home screen title', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await initDependencies();
    await tester.pumpWidget(const RollaScoresApp());

    await tester.pumpAndSettle();

    expect(find.text('Scores'), findsOneWidget);
  });
}
