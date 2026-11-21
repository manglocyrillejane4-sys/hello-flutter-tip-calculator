
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  testWidgets('Tip calculator computes tip and total',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TipApp());

    await tester.enterText(
      find.byType(TextField),
      '500',
    );

    await tester.tap(find.text('10%'));
    await tester.pump();

    expect(find.text('Tip: ₱50.00'), findsOneWidget);
    expect(find.text('Total: ₱550.00'), findsOneWidget);
  });

  testWidgets('Shows error for invalid bill',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TipApp());

    await tester.enterText(
      find.byType(TextField),
      'abc',
    );

    await tester.pump();

    expect(
      find.text('Enter a valid amount'),
      findsOneWidget,
    );
  });

  testWidgets('Shows error for empty bill',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TipApp());

    expect(
      find.text('Enter a valid amount'),
      findsOneWidget,
    );
  });
}
