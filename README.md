# Async Preferences

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

A flutter plugin to use local preferences asynchronously.

This plugin stands out for some significant differences compared to other preference management plugins:

- Provides `set` methods to save preferences and `get` methods to get them. There is no cache, the source of truth is the underlying preferences API. All operations are performed asynchronously using `Futures`.
- No prefix is used, the key you specify is the final key that will be used. Using this plugin you can obtain preferences saved by other components (such as other plugins, libraries or any component that accesses the underliying APIs to save/get preferences).
- Allows you to specify the read/write file on Android, so it is possible to save/get preferences from places other than the default space.
- Support for `long` (Android) and `Int64` (iOS) type preferences. In Flutter these values are set and returned as `int`, but on the native side the specified types are used.

For now this plugin only supports Android and iOS, it is not planned to support more platforms.

## How to use it

First, import the plugin:

`import 'package:async_preferences/async_preferences.dart';`

Create an instance of AsyncPreferences:

`final preferences = AsyncPreferences();`

Save a value:

`await preferences.setString('your_key', 'your_value');`

Get the value:

`final value = await preferences.getString('your_key');`;

Please note that if the value doesn't exist, the `get` methods will return `null`. You can specify a default value as follows:

`final value = await preferences.getString('your_key') ?? 'default_value';`;

Remove a value:

`await preferences.remove('your_key');`

Save and get a value in a custom file (Android only):

```
await preferences.setString('custom_file_value', 'your_value', file: 'custom_file');
final value = await preferences.getString('custom_file_value', file: 'custom_file');
```
