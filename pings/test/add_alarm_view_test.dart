import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pings/ui/add_alarm_view.dart';
import 'package:pings/ui/home_view.dart';

import 'helpers/test_app.dart';

void main() {
  group('Add Alarm View Tests -', () {
    testWidgets('Tapping close button pops widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: TestApp(),
        ),
      );
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.byType(AddAlarmView), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('updateTimePickerState is called picker change',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AddAlarmView(),
          ),
        ),
      );
      final hourPicker = find.byKey(const Key('hourPicker'));
      final minutePicker = find.byKey(const Key('minutePicker'));

      await tester.drag(hourPicker, const Offset(0.0, -100.0));
      await tester.pumpAndSettle();
      await tester.drag(minutePicker, const Offset(0.0, -100.0));
      await tester.pumpAndSettle();
    });
  });
}
