import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ogrenci_app/main.dart'; // Bu import'u koruyoruz çünkü 'OgrenciApp' burada tanımlı

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Ana widget'ınızın adını buraya yazın.
    await tester.pumpWidget(OgrenciApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
