import Flutter
import UIKit

let kMethodActionToNative = "methodActionToNative"

let kActionPush = "push"

public class SwiftTStackPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "t_stack", binaryMessenger: registrar.messenger())
        let instance = SwiftTStackPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == kMethodActionToNative) {
            let args = call.arguments as! Dictionary<String, Any>
            switch args["action"] as! String {
            case kActionPush:
                let args = call.arguments as! Dictionary<String, Any>
                handleFlutterPush(args)
            default:
                print("Unknown") // TODO warning
            }
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    func handleFlutterPush(_ args: Dictionary<String, Any>) {
        TNavigator.shared.pushRoute(args["routeName"] as! String)
    }
}
