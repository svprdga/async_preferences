import 'dart:math';

import 'package:flutter/material.dart';
import 'package:async_preferences/async_preferences.dart';

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
      this.defaultPreferencesValues, this.customPreferencesValues);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ****************************** CONSTANTS ****************************** //

  static const STRING_REF = 'string_value';
  static const INT_REF = 'int_value';
  static const BOOL_REF = 'bool_value';
  static const LONG_REF = 'long_value';

  static const CUSTOM_FILE = 'custom';

  // ********************************* VARS ******************************** //

  late AsyncPreferences _preferences;

  // ****************************** LIFECYCLE ****************************** //

  @override
  void initState() {
    super.initState();
    _preferences = AsyncPreferences();
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
          builder: (BuildContext context,
              AsyncSnapshot<PreferencesResult> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'Default preferences',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _getRow(
                      'String value:',
                      snapshot.data!.defaultPreferencesValues.stringValue !=
                              null
                          ? snapshot.data!.defaultPreferencesValues.stringValue!
                          : 'Value is null'),
                  _getRow(
                      'int value:',
                      snapshot.data!.defaultPreferencesValues.intValue != null
                          ? snapshot.data!.defaultPreferencesValues.intValue
                              .toString()
                          : 'Value is null'),
                  _getRow(
                      'bool value:',
                      snapshot.data!.defaultPreferencesValues.boolValue != null
                          ? snapshot.data!.defaultPreferencesValues.boolValue
                              .toString()
                          : 'Value is null'),
                  _getRow(
                      'long value:',
                      snapshot.data!.defaultPreferencesValues.longValue != null
                          ? snapshot.data!.defaultPreferencesValues.longValue
                              .toString()
                          : 'Value is null'),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                          child: Text('Save random values'),
                          onPressed: () async {
                            final now = DateTime.now();
                            final random = Random();

                            await _preferences.setString(
                                STRING_REF, now.toIso8601String());
                            await _preferences.setInt(
                                INT_REF, random.nextInt(100));
                            await _preferences.setBool(BOOL_REF,
                                value: random.nextInt(100) % 2 == 0);
                            await _preferences.setLong(LONG_REF, 2147483647);
                            setState(() {});
                          }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                          child: Text('Remove all values'),
                          onPressed: () async {
                            await _preferences.remove(STRING_REF);
                            await _preferences.remove(INT_REF);
                            await _preferences.remove(BOOL_REF);
                            await _preferences.remove(LONG_REF);
                            setState(() {});
                          }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
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
                          : 'Value is null'),
                  _getRow(
                      'int value:',
                      snapshot.data!.customPreferencesValues.intValue != null
                          ? snapshot.data!.customPreferencesValues.intValue
                              .toString()
                          : 'Value is null'),
                  _getRow(
                      'bool value:',
                      snapshot.data!.customPreferencesValues.boolValue != null
                          ? snapshot.data!.customPreferencesValues.boolValue
                              .toString()
                          : 'Value is null'),
                  _getRow(
                      'bool value:',
                      snapshot.data!.customPreferencesValues.longValue != null
                          ? snapshot.data!.customPreferencesValues.longValue
                              .toString()
                          : 'Value is null'),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                          child: Text('Save random values'),
                          onPressed: () async {
                            final now = DateTime.now();
                            final random = Random();

                            await _preferences.setString(
                                STRING_REF, now.toIso8601String(),
                                file: CUSTOM_FILE);
                            await _preferences.setInt(
                                INT_REF, random.nextInt(100),
                                file: CUSTOM_FILE);
                            await _preferences.setBool(BOOL_REF,
                                value: random.nextInt(100) % 2 == 0,
                                file: CUSTOM_FILE);
                            await _preferences.setLong(LONG_REF, 2147483647,
                                file: CUSTOM_FILE);
                            setState(() {});
                          }),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: ElevatedButton(
                          child: Text('Remove all values'),
                          onPressed: () async {
                            await _preferences.remove(STRING_REF,
                                file: CUSTOM_FILE);
                            await _preferences.remove(INT_REF,
                                file: CUSTOM_FILE);
                            await _preferences.remove(BOOL_REF,
                                file: CUSTOM_FILE);
                            await _preferences.remove(LONG_REF,
                                file: CUSTOM_FILE);
                            setState(() {});
                          }),
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

  // *************************** PRIVATE METHODS *************************** //

  Future<PreferencesResult> _getStoredValues() async {
    try {
      String? stringValue = await _preferences.getString(STRING_REF);
      int? intValue = await _preferences.getInt(INT_REF);
      bool? boolValue = await _preferences.getBool(BOOL_REF);
      int? longValue = await _preferences.getLong(LONG_REF);

      final defaultValues = ValuesWrapper(
        stringValue,
        intValue,
        boolValue,
        longValue,
      );

      String? customStringValue =
          await _preferences.getString(STRING_REF, file: CUSTOM_FILE);
      int? customIntValue =
          await _preferences.getInt(INT_REF, file: CUSTOM_FILE);
      bool? customBoolValue =
          await _preferences.getBool(BOOL_REF, file: CUSTOM_FILE);
      int? customLongValue =
          await _preferences.getLong(LONG_REF, file: CUSTOM_FILE);

      final customValues = ValuesWrapper(
        customStringValue,
        customIntValue,
        customBoolValue,
        customLongValue,
      );

      return PreferencesResult(defaultValues, customValues);
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  Widget _getRow(String label, String value) {
    return Row(
      children: [
        Text(label),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(value),
        )
      ],
    );
  }
}
