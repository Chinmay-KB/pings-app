import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pings/providers/providers.dart';
import 'package:google_fonts/google_fonts.dart';

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
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: AspectRatio(
                    aspectRatio: 380 / 131,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                          ),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 21.0, top: 15.0, bottom: 17.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                alarms[index].description,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Row(
                                children: [
                                  Text(
                                    '19:00',
                                    style: GoogleFonts.cabin(
                                      textStyle:
                                          const TextStyle(fontSize: 36.0),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.0,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Daily | Rings in 7h 10m',
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Created By ${alarms[index].createdBy} - ${alarms[index].numberOfPeople} people',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
