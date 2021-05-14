import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pings/ui/add_alarm_view.dart';

void main() {
  group('Time picker widget test -', () {
    testWidgets(
      'construct time picker',
      (WidgetTester tester) async {
        await tester.pumpWidget(
            const ProviderScope(child: MaterialApp(home: AddAlarmView())));
        await tester.pump();
        expect(find.byType(ShadedPicker), findsNWidgets((2)));
        await tester.tap(find.byIcon(Icons.close));
        await tester.pump();
        await tester.tap(find.byIcon(Icons.check));
        await tester.pump();
      },
    );
  });
}
