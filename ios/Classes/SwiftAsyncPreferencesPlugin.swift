import Flutter
import UIKit

public class SwiftAsyncPreferencesPlugin: NSObject, FlutterPlugin {
    
    // Vars
    
    let defaults = UserDefaults.standard
    
    // Public methods
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "async_preferences", binaryMessenger: registrar.messenger())
        let instance = SwiftAsyncPreferencesPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch(call.method) {
        case "set_string":
            setString(call: call, result: result)
            break;
        case "get_string":
            getString(call: call, result: result)
            break;
        case "set_bool":
            setBool(call: call, result: result)
            break;
        case "get_bool":
            getBool(call: call, result: result)
            break;
        case"set_int":
            setInt(call: call, result: result)
            break;
        case "get_int":
            getInt(call: call, result: result)
            break;
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Private methods
    
    private func setString(call: FlutterMethodCall, result: FlutterResult) {
        let list = call.arguments as! [String]
        defaults.set(list[1], forKey: list[0])
        result(nil)
    }
    
    private func getString(call: FlutterMethodCall, result: FlutterResult) {
        let list = call.arguments as! [String]
        let value = defaults.string(forKey: list[0])
        result(value)
    }
    
    private func setBool(call: FlutterMethodCall, result: FlutterResult) {
        let list = call.arguments as! [Any]
        defaults.set(list[1] as! Bool, forKey: list[0] as! String)
        result(nil)
    }
    
    private func getBool(call: FlutterMethodCall, result: FlutterResult) {
        let list = call.arguments as! [Any]
        let key = list[0] as! String
        if (existsKey(key: key)) {
            let value = defaults.bool(forKey: list[0] as! String)
            result(value)
        } else {
            result(nil)
        }
    }
    
    private func setInt(call: FlutterMethodCall, result: FlutterResult) {
        let list = call.arguments as! [Any]
        defaults.set(list[1] as! Int, forKey: list[0] as! String)
        result(nil)
    }
    
    private func getInt(call: FlutterMethodCall, result: FlutterResult) {
        let list = call.arguments as! [Any]
        let key = list[0] as! String
        if (existsKey(key: key)) {
            let value = defaults.integer(forKey: list[0] as! String)
            result(value)
        } else {
            result(nil)
        }
    }
    
    func existsKey(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
}
