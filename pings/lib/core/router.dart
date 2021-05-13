import 'package:flutter/material.dart';
import 'package:pings/ui/add_alarm_view.dart';

/// Contains all the routes for navigation.
class PingsRouter {
  /// Route for add alarm view.
  static const String addAlarmViewRoute = 'add_alarm_view';

  /// Generate routes used in the app.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case addAlarmViewRoute:
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var tween = Tween(begin: begin, end: end);
              var curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AddAlarmView());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
