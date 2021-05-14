import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pings/notifiers/time_picker_notifier.dart';

void main() {
  test('Verify return type of timePickerNotifier is DateTime', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(timePickerNotifier), isA<DateTime>());
  });

  group('timePickerNotifier tests -', () {
    test('updateTimePickerState', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      container.read(timePickerNotifier.notifier).updateTimePickerState(2, 2);
      expect(container.read(timePickerNotifier).hour, 2);
      expect(container.read(timePickerNotifier).minute, 2);
    });
  });
}
