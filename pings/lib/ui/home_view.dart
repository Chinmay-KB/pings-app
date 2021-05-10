import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pings/models/alarm.dart';
import 'package:pings/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pings/ui/icons.dart';

/// UI for home page.
class HomeView extends StatelessWidget {
  /// Constructor for HomeView.
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {},
            ),
          ],
          toolbarHeight: 56.0,
          centerTitle: true,
          title: const Text(
            'PINGS',
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 2.0,
              height: 1.2,
              fontSize: 20.0,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: Consumer(
          builder: (context, watch, child) {
            final alarms = watch(alarmsNotifierProvider);
            return alarms.when(
              () => const Center(
                child: Text(
                  '''
No active alarms
Create a new button from the button below''',
                  textAlign: TextAlign.center,
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error) => Center(child: Text(error)),
              success: (alarms) => ListView.builder(
                itemCount: alarms.length,
                itemBuilder: (context, index) => AlarmCard(alarms[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Alarm card shown on the homepage.
class AlarmCard extends StatelessWidget {
  /// Constructor for alarm card.
  const AlarmCard(this.alarm, {Key? key}) : super(key: key);

  /// Index of the card in the list.
  final Alarm alarm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 380 / 131,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.only(left: 21.0, top: 15.0, bottom: 17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AlarmDescription(
                  description: alarm.description,
                ),
                AlarmTimeText(
                  frequency: alarm.frequency,
                ),
                Text(
                  'Created By ${alarm.createdBy} - ${alarm.numberOfPeople} people',
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Displays the alarm time, frequency and time left in the alarm card.
class AlarmTimeText extends StatelessWidget {
  /// Constructor for AlarmTimeText.
  const AlarmTimeText({Key? key, required this.frequency}) : super(key: key);

  /// Frequency of the alarm.
  final String frequency;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Text(
              '19:00',
              style: GoogleFonts.cabin(
                textStyle: const TextStyle(fontSize: 36.0),
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                '$frequency | Rings in 7h 10m',
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Text widget for alarm desciption displayed in the alarm card.
class AlarmDescription extends StatelessWidget {
  /// Constructor for AlarmDescription.
  const AlarmDescription({Key? key, required this.description})
      : super(key: key);

  /// Description shown in the alarm card.
  final String description;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: description,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ),
            const WidgetSpan(
                child: SizedBox(
              width: 10.0,
            )),
            const WidgetSpan(
              child:
                  Icon(PingsIcons.groups, color: Color(0xFFC5C5C5), size: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
