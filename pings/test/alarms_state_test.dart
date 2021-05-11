import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pings/models/alarm.dart';
import 'package:pings/providers/providers.dart';
import 'package:pings/services/alarms_api_service.dart';
import 'package:pings/state/alarm_state.dart';

import 'alarms_state_test.mocks.dart';

@GenerateMocks([AlarmsApi])
void main() {
  test('Verify return type of alarmsNotifierProvider is AlarmsState', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(alarmsNotifierProvider), isA<AlarmsState>());
  });

  group('getAlarmsApi test', () {
    test('First state is loading state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(
          container.read(alarmsNotifierProvider), const AlarmsState.loading());
    });

    test(
        'should return AlarmsState()(initial state) when empty list is received from API',
        () async {
      final api = MockAlarmsApi();

      when(api.fetchAlarms()).thenAnswer((realInvocation) async => <Alarm>[]);
      final container = ProviderContainer(
        overrides: [
          alarmsApiProvider.overrideWithProvider(Provider((ref) => api))
        ],
      );
      await container.read(alarmsNotifierProvider.notifier).getAlarmsFromApi();
      expect(container.read(alarmsNotifierProvider.notifier).debugState,
          const AlarmsState());
    });
    test(
        'should return AlarmsState.success(<list of alarms>)(initial state) when non-empty list is received from API',
        () async {
      final api = MockAlarmsApi();

      final alarm = Alarm(
          createdBy: 'test',
          description: 'test',
          datetime: DateTime.now(),
          frequency: 'test',
          numberOfPeople: 1);

      when(api.fetchAlarms())
          .thenAnswer((realInvocation) async => <Alarm>[alarm]);
      final container = ProviderContainer(
        overrides: [
          alarmsApiProvider.overrideWithProvider(Provider((ref) => api))
        ],
      );
      await container.read(alarmsNotifierProvider.notifier).getAlarmsFromApi();
      expect(container.read(alarmsNotifierProvider.notifier).debugState,
          AlarmsState.success([alarm]));
    });
    test(
        'should return AlarmsState.error when exception is thrown from the API',
        () async {
      final api = MockAlarmsApi();
      when(api.fetchAlarms()).thenThrow(const SocketException('test'));

      final container = ProviderContainer(
        overrides: [
          alarmsApiProvider.overrideWithProvider(Provider((ref) => api))
        ],
      );

      await container.read(alarmsNotifierProvider.notifier).getAlarmsFromApi();
      expect(container.read(alarmsNotifierProvider.notifier).debugState,
          const AlarmsState.error('Could not fetch alarms.'));
    });
  });
}
