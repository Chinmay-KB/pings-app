import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pings/notifiers/alarm_notifier.dart';
import 'package:pings/services/alarms_api_service.dart';
import 'package:pings/state/alarm_state.dart';

/// Provider for alarms api.
final alarmsApiProvider = Provider<AlarmsApi>((ref) => FakeAlarmsApi());

/// Provides state notifier for alarms.
final alarmsNotifierProvider =
    StateNotifierProvider<AlarmsNotifier, AlarmsState>(
  (ref) => AlarmsNotifier(ref.watch(alarmsApiProvider)),
);
