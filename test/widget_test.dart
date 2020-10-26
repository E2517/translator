import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:translator/main.dart';

void main() {
  testWidgets('Test translator', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Spanish'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('UK'), findsOneWidget);

    expect(find.text('Russian'), findsNothing);

    await tester.tap(find.byIcon(Icons.mic));
  });
}
