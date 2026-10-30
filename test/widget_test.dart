import 'package:flutter_test/flutter_test.dart';

import 'package:app_tecnonni_flutter/main.dart';

void main() {
  testWidgets('Welcome screen shows the app name', (WidgetTester tester) async {
    await tester.pumpWidget(const TecnonniApp());
    await tester.pumpAndSettle();

    expect(find.text('Tecnononni'), findsOneWidget);
    expect(find.text('Iniziamo'), findsOneWidget);
  });
}