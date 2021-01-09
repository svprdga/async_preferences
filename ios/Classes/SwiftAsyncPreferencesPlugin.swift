import Flutter
import UIKit

public class SwiftAsyncPreferencesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "async_preferences", binaryMessenger: registrar.messenger())
    let instance = SwiftAsyncPreferencesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    switch call.method {
        case "get_string":
            result("hola")
        case "get_int":
            result(23)
        case "get_bool":
            result(true)
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
