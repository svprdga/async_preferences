import 'package:flutter/material.dart';
import 'package:async_preferences/async_preferences.dart';

void main() {
  runApp(MyApp());
}

class ValuesWrapper {
  final String stringValue;
  final int intValue;
  final bool boolValue;

  ValuesWrapper(this.stringValue, this.intValue, this.boolValue);
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

  // ********************************* VARS ******************************** //

  AsyncPreferences _preferences;
  Future<ValuesWrapper> _future;

  // ****************************** LIFECYCLE ****************************** //

  @override
  void initState() {
    super.initState();
    _preferences = AsyncPreferences.getInstance();
    _future = _getStoredValues();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AsyncPreferences test app'),
        ),
        body: FutureBuilder<ValuesWrapper>(
          future: _future,
          builder:
              (BuildContext context, AsyncSnapshot<ValuesWrapper> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView(
                children: [
                  _getRow(
                      'String value:',
                      snapshot.data.stringValue != null
                          ? snapshot.data.stringValue
                          : 'Value is null'),
                  _getRow(
                      'int value:',
                      snapshot.data.intValue != null
                          ? snapshot.data.intValue.toString()
                          : 'Value is null'),
                  _getRow(
                      'bool value:',
                      snapshot.data.boolValue != null
                          ? snapshot.data.boolValue.toString()
                          : 'Value is null')
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // *************************** PRIVATE METHODS *************************** //

  Future<ValuesWrapper> _getStoredValues() async {
    try {
      String stringValue = await _preferences.getString(STRING_REF);
      int intValue = await _preferences.getInt(INT_REF);
      bool boolValue = await _preferences.getBool(BOOL_REF);

      return ValuesWrapper(stringValue, intValue, boolValue);
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
