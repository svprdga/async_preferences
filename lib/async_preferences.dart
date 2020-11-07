
import 'dart:async';

import 'package:flutter/services.dart';

class AsyncPreferences {
  static const MethodChannel _channel =
      const MethodChannel('async_preferences');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
