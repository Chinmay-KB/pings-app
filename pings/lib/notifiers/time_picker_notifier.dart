import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the state for time picker.
final timePickerNotifier = StateNotifierProvider<TimePickerNotifier, DateTime>(
  (ref) => TimePickerNotifier(),
);

/// Notifies state for time shown in the time picker for alarms.
class TimePickerNotifier extends StateNotifier<DateTime> {
  /// Constructor for TimePickerNotifier.
  TimePickerNotifier([DateTime? state])
      : super(
          state ?? DateTime.now(),
        );

  /// DateTime value for the time when a TimePickerNotifier is constructed.
  DateTime now = DateTime.now();

  /// Updates the time picker state with the hour value and minute value
  /// received from the number picker.
  void updateTimePickerState(int hourVal, int minuteVal) {
    if (hourVal < state.hour || minuteVal < state.minute) {}
    state = state.copyWith(hour: hourVal, minute: minuteVal);
  }
}

/// DateTime utils.
extension MyDateUtils on DateTime {
  /// copyWith for DateTime.
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
