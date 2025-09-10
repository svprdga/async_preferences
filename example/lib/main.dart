import 'dart:math';

import 'package:async_preferences/async_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ValuesWrapper {
  final String? stringValue;
  final int? intValue;
  final bool? boolValue;
  final int? longValue;

  ValuesWrapper(
    this.stringValue,
    this.intValue,
    this.boolValue,
    this.longValue,
  );
}

class PreferencesResult {
  final ValuesWrapper defaultPreferencesValues;
  final ValuesWrapper customPreferencesValues;

  PreferencesResult(
    this.defaultPreferencesValues,
    this.customPreferencesValues,
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _stringRef = 'string_value';
  static const _intRef = 'int_value';
  static const _boolRef = 'bool_value';
  static const _longRef = 'long_value';

  static const _customFile = 'custom';

  late AsyncPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _preferences = AsyncPreferences(
      keysToMigrate: [
        _stringRef,
        _intRef,
        _boolRef,
        _longRef,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AsyncPreferences test app'),
        ),
        body: FutureBuilder<PreferencesResult>(
          future: _getStoredValues(),
          builder: (
            BuildContext context,
            AsyncSnapshot<PreferencesResult> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Center(
                      child: Text(
                        'Default preferences',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _getRow(
                    'String value:',
                    snapshot.data!.defaultPreferencesValues.stringValue != null
                        ? snapshot.data!.defaultPreferencesValues.stringValue!
                        : 'Value is null',
                  ),
                  _getRow(
                    'int value:',
                    snapshot.data!.defaultPreferencesValues.intValue != null
                        ? snapshot.data!.defaultPreferencesValues.intValue
                            .toString()
                        : 'Value is null',
                  ),
                  _getRow(
                    'bool value:',
                    snapshot.data!.defaultPreferencesValues.boolValue != null
                        ? snapshot.data!.defaultPreferencesValues.boolValue
                            .toString()
                        : 'Value is null',
                  ),
                  _getRow(
                    'long value:',
                    snapshot.data!.defaultPreferencesValues.longValue != null
                        ? snapshot.data!.defaultPreferencesValues.longValue
                            .toString()
                        : 'Value is null',
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Save random values'),
                        onPressed: () async {
                          final now = DateTime.now();
                          final random = Random();

                          await _preferences.setString(
                            _stringRef,
                            now.toIso8601String(),
                          );
                          await _preferences.setInt(
                            _intRef,
                            random.nextInt(100),
                          );
                          await _preferences.setBool(
                            _boolRef,
                            // ignore: use_is_even_rather_than_modulo - no need to change it.
                            value: random.nextInt(100) % 2 == 0,
                          );
                          await _preferences.setLong(_longRef, 2147483647);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Remove all values'),
                        onPressed: () async {
                          await _preferences.remove(_stringRef);
                          await _preferences.remove(_intRef);
                          await _preferences.remove(_boolRef);
                          await _preferences.remove(_longRef);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Center(
                      child: Text(
                        'Custom preferences file',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _getRow(
                    'String value:',
                    snapshot.data!.customPreferencesValues.stringValue != null
                        ? snapshot.data!.customPreferencesValues.stringValue!
                        : 'Value is null',
                  ),
                  _getRow(
                    'int value:',
                    snapshot.data!.customPreferencesValues.intValue != null
                        ? snapshot.data!.customPreferencesValues.intValue
                            .toString()
                        : 'Value is null',
                  ),
                  _getRow(
                    'bool value:',
                    snapshot.data!.customPreferencesValues.boolValue != null
                        ? snapshot.data!.customPreferencesValues.boolValue
                            .toString()
                        : 'Value is null',
                  ),
                  _getRow(
                    'bool value:',
                    snapshot.data!.customPreferencesValues.longValue != null
                        ? snapshot.data!.customPreferencesValues.longValue
                            .toString()
                        : 'Value is null',
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Save random values'),
                        onPressed: () async {
                          final now = DateTime.now();
                          final random = Random();

                          await _preferences.setString(
                            _stringRef,
                            now.toIso8601String(),
                            file: _customFile,
                          );
                          await _preferences.setInt(
                            _intRef,
                            random.nextInt(100),
                            file: _customFile,
                          );
                          await _preferences.setBool(
                            _boolRef,
                            // ignore: use_is_even_rather_than_modulo - no need to change it.
                            value: random.nextInt(100) % 2 == 0,
                            file: _customFile,
                          );
                          await _preferences.setLong(
                            _longRef,
                            2147483647,
                            file: _customFile,
                          );
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                        child: const Text('Remove all values'),
                        onPressed: () async {
                          await _preferences.remove(
                            _stringRef,
                            file: _customFile,
                          );
                          await _preferences.remove(
                            _intRef,
                            file: _customFile,
                          );
                          await _preferences.remove(
                            _boolRef,
                            file: _customFile,
                          );
                          await _preferences.remove(
                            _longRef,
                            file: _customFile,
                          );
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<PreferencesResult> _getStoredValues() async {
    try {
      final String? stringValue = await _preferences.getString(_stringRef);
      final int? intValue = await _preferences.getInt(_intRef);
      final bool? boolValue = await _preferences.getBool(_boolRef);
      final int? longValue = await _preferences.getLong(_longRef);

      final defaultValues = ValuesWrapper(
        stringValue,
        intValue,
        boolValue,
        longValue,
      );

      final String? customStringValue =
          await _preferences.getString(_stringRef, file: _customFile);
      final int? customIntValue =
          await _preferences.getInt(_intRef, file: _customFile);
      final bool? customBoolValue =
          await _preferences.getBool(_boolRef, file: _customFile);
      final int? customLongValue =
          await _preferences.getLong(_longRef, file: _customFile);

      final customValues = ValuesWrapper(
        customStringValue,
        customIntValue,
        customBoolValue,
        customLongValue,
      );

      return PreferencesResult(defaultValues, customValues);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Widget _getRow(String label, String value) {
    return Row(
      children: [
        Text(label),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(value),
        ),
      ],
    );
  }
}
