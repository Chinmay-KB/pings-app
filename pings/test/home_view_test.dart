import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pings/models/alarm.dart';
import 'package:pings/notifiers/alarm_notifier.dart';
import 'package:pings/providers/providers.dart';
import 'package:pings/services/alarms_api_service.dart';
import 'package:pings/ui/home_view.dart';

class TestAlarmsApi implements AlarmsApi {
  TestAlarmsApi({this.emptyList = false});
  final bool emptyList;

  @override
  Future<List<Alarm>> fetchAlarms() {
    if (!emptyList)
      throw (const SocketException('No internet'));
    else
      return Future.value(<Alarm>[]);
  }
}

void main() {
  testWidgets(
    'Appbar, Fab, IconButton test',
    (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(
          home: HomeView(),
        ),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final textFinder = find.text('PINGS');
      final fab = find.byType(FloatingActionButton);
      final icon = find.byType(IconButton);
      await tester.tap(icon);
      await tester.tap(fab);
      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'When error is received, it shows in the UI',
    (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [
          alarmsApiProvider.overrideWithValue(TestAlarmsApi()),
        ],
        child: const MaterialApp(
          home: HomeView(),
        ),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      final finder = find.text('Could not fetch alarms.');
      expect(finder, findsOneWidget);
    },
  );

  testWidgets(
    'When initial state is received, no alarms text is shown',
    (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [
          alarmsNotifierProvider.overrideWithProvider(StateNotifierProvider(
              (ref) => AlarmsNotifier(TestAlarmsApi(emptyList: true))))
        ],
        child: const MaterialApp(
          home: HomeView(),
        ),
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.byType(Text), findsNWidgets(2));
    },
  );
}
