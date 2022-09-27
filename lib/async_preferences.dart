import 'dart:async';

import 'package:flutter/services.dart';

class AsyncPreferences {
  // ********************************* VARS ******************************** //

  static const MethodChannel _channel = MethodChannel('async_preferences');

  //***************************** PUBLIC METHODS *************************** //

  /// Remove a value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  Future<bool?> remove(String id, {String? file}) async {
    return _channel.invokeMethod('remove', [file, id]);
  }

  /// Save a [String] value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setString(String id, String value, {String? file}) async {
    return _channel.invokeMethod('set_string', [file, id, value]);
  }

  /// Retrieve a [String] value by the given [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// The return value will be null if the given [id] was never used.
  Future<String?> getString(String id, {String? file}) async {
    return _channel.invokeMethod('get_string', [file, id]);
  }

  /// Save a [bool] value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setBool(String id, {required bool value, String? file}) async {
    return _channel.invokeMethod('set_bool', [file, id, value]);
  }

  /// Retrieve a [bool] value by the given [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// The return value will be null if the given [id] was never used.
  Future<bool?> getBool(String id, {String? file}) async {
    return _channel.invokeMethod('get_bool', [file, id]);
  }

  /// Save an [int] value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setInt(String id, int value, {String? file}) async {
    return _channel.invokeMethod('set_int', [file, id, value]);
  }

  /// Retrieve an [int] value by the given [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// The return value will be null if the given [id] was never used.
  Future<int?> getInt(String id, {String? file}) async {
    return _channel.invokeMethod('get_int', [file, id]);
  }

  /// Save an [int] value that is going to be casted to a Long value in the native platform.
  ///
  /// Integer values in dart uses the same amount of bytes that Long values in native platforms, so it is safe to use this method without loosing precision.
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setLong(String id, int value, {String? file}) async {
    return _channel.invokeMethod('set_long', [file, id, value.toString()]);
  }

  /// Retrieve an [int] value by the given [id]. The value must be saved as a Long value in the native platform.
  ///
  /// Integer values in dart uses the same amount of bytes that Long values in native platforms, so it is safe to use this method without loosing precision.
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// The return value will be null if the given [id] was never used.
  Future<int?> getLong(String id, {String? file}) async {
    return _channel.invokeMethod('get_long', [file, id]);
  }
}
