import 'dart:async';

import 'package:flutter/services.dart';

/// AsyncPreferences provides a simple key-value storage solution for Flutter
/// applications.
///
/// **IMPORTANT MIGRATION NOTICE:**
/// Starting from version 2.0.0, this plugin migrates from SharedPreferences
/// to DataStore on Android for better performance and reliability.
/// During the first app launch after upgrading to version 2.X.X, a one-time
/// migration will occur to transfer your specified keys from SharedPreferences
/// to DataStore.
///
/// **WARNING:** Never downgrade this plugin below version 2.X.X after using it,
/// as this would cause permanent data loss for your users.
/// The DataStore format is not compatible with SharedPreferences.
///
/// The migration is selective - only the keys you specify in the constructor
/// will be migrated, leaving other plugin data intact in SharedPreferences.
class AsyncPreferences {
  static const MethodChannel _channel = MethodChannel('async_preferences');

  /// Creates a new [AsyncPreferences] instance.
  ///
  /// **Required parameter:**
  /// - [keysToMigrate]: A list of preference keys that should be migrated from
  ///   SharedPreferences to DataStore. Only specify keys that belong to your
  ///   application to avoid interfering with other plugins.
  ///
  /// **Migration behavior:**
  /// - On first app launch with version 2.X.X, specified keys will be migrated
  ///   from SharedPreferences to DataStore
  /// - Keys not in this list will remain in SharedPreferences for other plugins
  /// - The migration happens only once per app installation
  /// - The migration is idempotent: you can safely declare your keys and leave
  ///   them in the constructor, subsequent app launches will not re-migrate
  /// - After migration, your app will use DataStore for all operations
  ///
  /// **Example:**
  /// ```dart
  /// final prefs = AsyncPreferences(keysToMigrate: [
  ///   'user_name',
  ///   'user_email',
  ///   'app_settings',
  ///   'user_preferences'
  /// ]);
  /// ```
  ///
  /// **Version compatibility:**
  /// - Versions < 2.0.0: Uses SharedPreferences
  /// - Versions >= 2.0.0: Uses DataStore with selective migration
  AsyncPreferences({required List<String> keysToMigrate}) {
    _channel.invokeMethod('keys_to_migrate', keysToMigrate);
  }

  /// Remove a value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  Future<bool?> remove(String id, {String? file}) {
    return _channel.invokeMethod('remove', [file, id]);
  }

  /// Save a [String] value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setString(String id, String value, {String? file}) {
    return _channel.invokeMethod('set_string', [file, id, value]);
  }

  /// Retrieve a [String] value by the given [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// The return value will be null if the given [id] was never used.
  Future<String?> getString(String id, {String? file}) {
    return _channel.invokeMethod('get_string', [file, id]);
  }

  /// Save a [bool] value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setBool(String id, {required bool value, String? file}) {
    return _channel.invokeMethod('set_bool', [file, id, value]);
  }

  /// Retrieve a [bool] value by the given [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// The return value will be null if the given [id] was never used.
  Future<bool?> getBool(String id, {String? file}) {
    return _channel.invokeMethod('get_bool', [file, id]);
  }

  /// Save an [int] value with the specified [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// Returns true if the value was successfully saved, returns false otherwise.
  Future<bool?> setInt(String id, int value, {String? file}) {
    return _channel.invokeMethod('set_int', [file, id, value]);
  }

  /// Retrieve an [int] value by the given [id].
  ///
  /// Optionally, specify the target [file] to perform the action
  /// against (Android only).
  ///
  /// The return value will be null if the given [id] was never used.
  Future<int?> getInt(String id, {String? file}) {
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
  Future<bool?> setLong(String id, int value, {String? file}) {
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
  Future<int?> getLong(String id, {String? file}) {
    return _channel.invokeMethod('get_long', [file, id]);
  }
}
