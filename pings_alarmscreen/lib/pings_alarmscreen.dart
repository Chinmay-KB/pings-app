
import 'dart:async';

import 'package:flutter/services.dart';

class PingsAlarmscreen {
  static const MethodChannel _channel =
      const MethodChannel('pings_alarmscreen');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
