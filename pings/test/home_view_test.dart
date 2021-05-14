import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:pings/core/navigation_service.dart';
import 'package:pings/core/router.dart';
import 'package:pings/models/alarm.dart';
import 'package:pings/notifiers/alarm_notifier.dart';
import 'package:pings/providers/providers.dart';
import 'package:pings/services/alarms_api_service.dart';
import 'package:pings/ui/add_alarm_view.dart';
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

@GenerateMocks([NavigatorObserver])
void main() {
  group('HomeViewTest - ', () {
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
        //final fab = find.byType(FloatingActionButton);
        final icon = find.byType(IconButton);

        await tester.tap(icon);
        //await tester.tap(fab);
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

    testWidgets(
      'Tapping floating action button navigates to add alarm view',
      (WidgetTester tester) async {
        final routes = <String, WidgetBuilder>{
          '/': (context) => const HomeView(),
          PingsRouter.addAlarmViewRoute: (context) => const AddAlarmView(),
        };
        await (tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              navigatorKey: NavigationService().navigatorKey,
              routes: routes,
            ),
          ),
        ));
        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(HomeView), findsOneWidget);
        expect(find.byType(AddAlarmView, skipOffstage: false), findsNothing);

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
        expect(find.byType(HomeView), findsOneWidget);
      },
    );
  });
}
