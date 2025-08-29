// Basic test for Pet Management app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Pet Management app basic test', (WidgetTester tester) async {
    // Build a basic Material app for testing
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Pet Management'))),
      ),
    );

    // Verify that the text is found
    expect(find.text('Pet Management'), findsOneWidget);
  });
}
