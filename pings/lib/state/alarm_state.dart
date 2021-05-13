import 'package:pings/models/alarm.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_state.freezed.dart';

/// State declarations for all the states of alarms list.
@freezed
class AlarmsState with _$AlarmsState {
  /// Initial state of Alarms.
  const factory AlarmsState() = _Initial;

  /// Loading state of Alarms.
  const factory AlarmsState.loading() = _Loading;

  /// Success state of Alarms.
  const factory AlarmsState.success(List<Alarm> alarms) = _Success;

  /// Error state of Alarms.
  const factory AlarmsState.error(String message) = _Error;
}
