import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm.freezed.dart';

/// Alarm data model.
@freezed
abstract class Alarm with _$Alarm {
  /// Constructor for Alarm.
  const factory Alarm({
    required DateTime datetime,
    required String createdBy,
    required String description,
    required int numberOfPeople,
  }) = _Alarm;
}
