import 'dart:async';

import 'package:flutter/services.dart';

class AsyncPreferences {
  // ********************************* VARS ******************************** //

  static const MethodChannel _channel =
      const MethodChannel('async_preferences');

  //***************************** PUBLIC METHODS *************************** //

  Future<bool?> remove(String id) async {
    return await _channel.invokeMethod('remove', [id]);
  }

  /// Save a [String] value with the specified [id].
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setString(String id, String value) async {
    return await _channel.invokeMethod('set_string', [id, value]);
  }

  /// Retrieve a [String] value by the given [id].
  ///
  /// The return value will be null if the given [id] was never used.
  Future<String?> getString(String id) async {
    return await _channel.invokeMethod('get_string', [id]);
  }

  /// Save a [bool] value with the specified [id].
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setBool(String id, bool value) async {
    return await _channel.invokeMethod('set_bool', [id, value]);
  }

  /// Retrieve a [bool] value by the given [id].
  ///
  /// The return value will be null if the given [id] was never used.
  Future<bool?> getBool(String id) async {
    return await _channel.invokeMethod('get_bool', [id]);
  }

  /// Save an [int] value with the specified [id].
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setInt(String id, int value) async {
    return await _channel.invokeMethod('set_int', [id, value]);
  }

  /// Retrieve an [int] value by the given [id].
  ///
  /// The return value will be null if the given [id] was never used.
  Future<int?> getInt(String id) async {
    return await _channel.invokeMethod('get_int', [id]);
  }
}
