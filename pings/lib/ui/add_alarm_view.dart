import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';

/// View to add alarm. Shows the time picker and options for other screens and
/// date picker.
class AddAlarmView extends StatefulWidget {
  /// Constructor for AddAlarmView.
  const AddAlarmView({Key? key}) : super(key: key);

  @override
  _AddAlarmViewState createState() => _AddAlarmViewState();
}

class _AddAlarmViewState extends State<AddAlarmView> {
  int _hourvalue = now.hour;
  int _minutevalue = (5 * (now.minute / 5).ceil());
  static DateTime now = DateTime.now();
  DateTime selectedDateTime = DateTime.now();
  final TextStyle selectedTimeStyle = GoogleFonts.cabin(
      color: const Color(0xFF4F4F4F), fontSize: 36.0, height: 1.2);
  final TextStyle unselectedTimeStyle = GoogleFonts.cabin(
      color: const Color(0xFF4F4F4F).withOpacity(0.5),
      letterSpacing: -1,
      fontSize: 36.0,
      height: 1.2);

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
            onPressed: () {}),
        actions: [
          IconButton(
              icon: const Icon(Icons.check, color: Colors.black),
              onPressed: () {})
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 45.0),
            child: Text(
              'Alarm in ${now.difference(selectedDateTime).inHours.abs()} hours and ${now.difference(selectedDateTime).inMinutes.abs() - now.difference(selectedDateTime).inHours.abs() * 60} minutes',
              textAlign: TextAlign.center,
              style: GoogleFonts.cabin(height: 1.2, fontSize: 14.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShadedPicker(
                picker: NumberPicker(
                  zeroPad: true,
                  itemCount: 5,
                  minValue: 0,
                  maxValue: 23,
                  itemHeight: 44,
                  infiniteLoop: true,
                  value: _hourvalue,
                  selectedTextStyle: selectedTimeStyle,
                  textStyle: unselectedTimeStyle,
                  onChanged: (int value) {
                    setState(() {
                      now = DateTime.now();
                      selectedDateTime = DateTime(
                          now.year, now.month, now.day, value, now.minute);
                      _hourvalue = value;
                    });
                  },
                ),
              ),
              ShadedPicker(
                picker: NumberPicker(
                  zeroPad: true,
                  itemCount: 5,
                  minValue: 0,
                  maxValue: 55,
                  itemHeight: 44,
                  infiniteLoop: true,
                  step: 5,
                  selectedTextStyle: selectedTimeStyle,
                  textStyle: unselectedTimeStyle,
                  value: _minutevalue,
                  onChanged: (int value) {
                    setState(() {
                      now = DateTime.now();
                      selectedDateTime = DateTime(
                          now.year, now.month, now.day, _hourvalue, value);
                      _minutevalue = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Number picker with shaded edges.
class ShadedPicker extends StatelessWidget {
  /// Constructor for ShadedPicker.
  const ShadedPicker({Key? key, required this.picker}) : super(key: key);

  /// The child number picker.
  final NumberPicker picker;

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
      child: picker,
    );
  }
}
