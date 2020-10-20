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

    // Not expected
    expect(find.text('Russian'), findsNothing);
  });
}
