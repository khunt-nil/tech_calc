import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tech_calc/main.dart';

void main() {
  testWidgets('Calculator UI test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(TechCalcApp());

    // Verify that the initial expression is empty.
    expect(find.text(''), findsNWidgets(2));  // Expecting two empty texts: one for expression, one for result

    // Enter a simple expression like '1 + 1' and check the result.
    await tester.tap(find.text('1'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('='));

    await tester.pump();

    // Verify that the calculator shows the correct result.
    expect(find.text('2.0'), findsOneWidget);
  });
}
