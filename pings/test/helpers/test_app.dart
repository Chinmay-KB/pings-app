import 'package:flutter/material.dart';
import 'package:pings/core/navigation_service.dart';
import 'package:pings/core/router.dart';
import 'package:pings/ui/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeView(),
      navigatorKey: context.read(navigatorProvider).navigatorKey,
      onGenerateRoute: PingsRouter.generateRoute,
    );
  }
}
