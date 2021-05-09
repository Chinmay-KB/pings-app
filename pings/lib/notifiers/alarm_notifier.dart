import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pings/services/alarms_api_service.dart';
import 'package:pings/state/alarm_state.dart';

/// State notifier for alarms.
class AlarmsNotifier extends StateNotifier<AlarmsState> {
  /// Constructor for alarms notifier.
  AlarmsNotifier(this._alarmsApi) : super(const AlarmsState()) {
    getAlarmsFromApi();
  }

  final AlarmsApi _alarmsApi;

  /// Calls the alarms api service to fetch alarms.
  Future<void> getAlarmsFromApi() async {
    try {
      state = const AlarmsState.loading();
      final alarms = await _alarmsApi.fetchAlarms();
      if (alarms.isNotEmpty)
        state = AlarmsState.success(alarms);
      else
        state = const AlarmsState();
    } on SocketException {
      state = const AlarmsState.error('Could not fetch alarms.');
    }
  }
}
