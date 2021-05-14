import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pings/core/navigation_service.dart';
import 'package:pings/notifiers/time_picker_notifier.dart';

/// View to add alarm. Shows the time picker and options for other screens and
/// date picker.
class AddAlarmView extends StatelessWidget {
  /// Constructor for AddAlarmView.
  const AddAlarmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Alarm'),
        elevation: 0.0,
        textTheme:
            Theme.of(context).copyWith(brightness: Brightness.dark).textTheme,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => context.read(navigatorProvider).goBack()),
        actions: [
          IconButton(
              icon: const Icon(Icons.check, color: Colors.black),
              onPressed: () {})
        ],
      ),
      body: ListView(
        children: [const PingsTimePicker()],
      ),
    );
  }
}

/// Time picker for add alarm view.
class PingsTimePicker extends ConsumerWidget {
  /// Constructor PingsTimePicker.
  const PingsTimePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _now = DateTime.now();
    final _selectedDateTime = watch(timePickerNotifier);
    final _difference = _selectedDateTime.difference(_now);
    final _diffHour = _difference.inHours;
    final _diffMin = _difference.inMinutes.abs() - _diffHour * 60;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 45.0),
          child: Text(
            'Alarm in $_diffHour hours and $_diffMin minutes',
            textAlign: TextAlign.center,
            style: GoogleFonts.cabin(height: 1.2, fontSize: 14.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadedPicker(
              key: const Key('hourPicker'),
              minValue: 0,
              maxValue: 23,
              step: 1,
              value: _selectedDateTime.hour,
              onChanged: (int value) {
                context
                    .read(
                      timePickerNotifier.notifier,
                    )
                    .updateTimePickerState(value, _selectedDateTime.minute);
              },
            ),
            ShadedPicker(
              key: const Key('minutePicker'),
              minValue: 0,
              maxValue: 59,
              step: 5,
              value: 5 * (_selectedDateTime.minute / 5).floor(),
              onChanged: (int value) {
                context
                    .read(
                      timePickerNotifier.notifier,
                    )
                    .updateTimePickerState(_selectedDateTime.hour, value);
              },
            ),
          ],
        ),
      ],
    );
  }
}

/// Number picker with shaded edges.
class ShadedPicker extends StatelessWidget {
  /// Constructor for ShadedPicker.
  ShadedPicker({
    Key? key,
    required this.onChanged,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.step,
  }) : super(key: key);

  /// Function callback to execute when value in picker changes
  final Function(int) onChanged;

  /// Minimum value of the picker.
  final int minValue;

  /// Maximum value of the picker.
  final int maxValue;

  /// Value currently shown in the picker.
  final int value;

  /// Difference between the values show in the picker.
  final int step;

  final TextStyle _selectedTimeStyle = GoogleFonts.cabin(
      color: const Color(0xFF4F4F4F), fontSize: 36.0, height: 1.2);
  final TextStyle _unselectedTimeStyle = GoogleFonts.cabin(
      color: const Color(0xFF4F4F4F).withOpacity(0.5),
      letterSpacing: -1,
      fontSize: 36.0,
      height: 1.2);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.transparent,
            Colors.transparent,
            Colors.white
          ],
          stops: [0.0, 0.30, 0.70, 1.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: NumberPicker(
        zeroPad: true,
        itemCount: 5,
        minValue: minValue,
        maxValue: maxValue,
        itemHeight: 44,
        step: step,
        infiniteLoop: true,
        value: value,
        selectedTextStyle: _selectedTimeStyle,
        textStyle: _unselectedTimeStyle,
        onChanged: onChanged,
      ),
    );
  }
}
