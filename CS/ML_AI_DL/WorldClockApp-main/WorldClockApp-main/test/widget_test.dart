// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:dart_1/main.dart';

class MockDateTime extends Mock implements DateTime {}

class MockTimeZone extends Mock implements tz.TimeZone {}

void main() {
  setUpAll(() {
    // Mock DateTime and TimeZone classes
    final mockDateTime = MockDateTime();
    final mockTimeZone = MockTimeZone();

    // Set up default return values for mock objects
    when(mockDateTime.now()).thenReturn(DateTime.utc(2022, 1, 1));
    when(mockTimeZone.getLocation(any)).thenReturn(tz.getLocation('UTC'));

    // Inject the mock objects into the main class
    WorldClockScreen.dateTime = mockDateTime;
    WorldClockScreen.timeZone = mockTimeZone;
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('12:00 AM'), findsOneWidget);
    expect(find.text('January 1, 2022'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('12:01 AM'), findsOneWidget);
    expect(find.text('January 1, 2022'), findsOneWidget);
  });
}
