import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:translator/main.dart';

void main() {
  testWidgets('Test translator', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that you have Spanish and English.
    expect(find.text('Spanish'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('UK'), findsOneWidget);

    expect(find.text('Russian'), findsNothing);

    // Verify that you have enter text.
    expect(find.text('Enter text'), findsOneWidget);

    // Verify that you do not have Introduce texto.
    expect(find.text('Introduce texto'), findsNothing);

    // Verify that you have Icon with a mic
    tester.tap(find.widgetWithIcon(FloatingActionButton, Icons.mic));
  });
}
