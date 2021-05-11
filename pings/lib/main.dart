import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pings/ui/home_view.dart';

void main() {
  runApp(const ProviderScope(child: PingsApp()));
}

/// Main Application Widget.
class PingsApp extends StatelessWidget {
  /// Constructor for PingsApp.
  const PingsApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
