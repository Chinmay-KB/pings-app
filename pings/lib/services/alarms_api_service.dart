import 'dart:io';
import 'dart:math';

import 'package:pings/models/alarm.dart';

/// Service to handle fetching of alarms.
abstract class AlarmsApi {
  /// Fetches alarms from the API.
  Future<List<Alarm>> fetchAlarms();
}

/// Fake api for alarms.
class FakeAlarmsApi extends AlarmsApi {
  @override
  Future<List<Alarm>> fetchAlarms() {
    return Future.delayed(const Duration(seconds: 1), () {
      final random = Random();

      if (random.nextBool()) {
        throw const SocketException('Could not connect to the internet');
      }

      return [
        Alarm(
          createdBy: 'You',
          description: 'Football',
          datetime: DateTime(random.nextInt(10) * 2000),
          numberOfPeople: 3,
        ),
        Alarm(
          createdBy: 'You',
          description: 'Cricket',
          datetime: DateTime(random.nextInt(10) * 2000),
          numberOfPeople: 11,
        ),
      ];
    });
  }
}
