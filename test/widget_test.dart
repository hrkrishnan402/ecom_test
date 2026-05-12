import 'package:flutter_test/flutter_test.dart';

import 'package:app/app.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    // Verify the app renders without crashing.
    expect(find.byType(App), findsOneWidget);
  });
}
