import Flutter
import UIKit

let kMethodActionToNative = "methodActionToNative"
let kMethodActionToFlutter = "methodActionToFlutter"

let kActionPush = "push"

public class SwiftTStackPlugin: NSObject, FlutterPlugin {
    static let shared = SwiftTStackPlugin()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "t_stack", binaryMessenger: registrar.messenger())
        SwiftTStackPlugin.shared.channel = channel
        registrar.addMethodCallDelegate(SwiftTStackPlugin.shared, channel: channel)
    }

    var channel: FlutterMethodChannel!

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

    func pushRoute(_ routeName: String) {
        channel.invokeMethod(kMethodActionToFlutter, arguments: [
            "action": kActionPush,
            "routeName": routeName
        ])
    }
}
