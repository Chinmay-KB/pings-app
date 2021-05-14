import 'package:flutter_test/flutter_test.dart';
import 'package:pings/notifiers/time_picker_notifier.dart';

void main() {
  test('DateTimeUtils copyWith', () {
    final dateTime = DateTime.now();
    final dateTime2 = dateTime.copyWith();
    expect(dateTime2.year, dateTime.year);
    expect(dateTime2.month, dateTime.month);
  });
}
