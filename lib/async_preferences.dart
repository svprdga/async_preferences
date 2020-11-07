
import 'dart:async';

import 'package:flutter/services.dart';

class AsyncPreferences {

  // ********************************* VARS ******************************** //

  static const MethodChannel _channel =
  const MethodChannel('async_preferences');

  static AsyncPreferences _instance;

  //***************************** PUBLIC METHODS *************************** //

  static AsyncPreferences getInstance() {
    if (_instance == null) {
      _instance = AsyncPreferences();
    }
    return _instance;
  }

  Future<bool> setString(String id, String value) async {
    return await _channel.invokeMethod('set_string', [id, value]);
  }

  Future<String> getString(String id) async {
    return await _channel.invokeMethod('get_string', [id]);
  }

  Future<bool> setBool(String id, bool value) async {
    return await _channel.invokeMethod('set_bool', [id, value]);
  }

  Future<bool> getBool(String id) async {
    return await _channel.invokeMethod('get_bool', [id]);
  }

  Future<bool> setInt(String id, int value) async {
    return await _channel.invokeMethod('set_int', [id, value]);
  }

  Future<int> getInt(String id) async {
    return await _channel.invokeMethod('get_int', [id]);
  }
}
