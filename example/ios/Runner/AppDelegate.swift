import UIKit
import Flutter
import t_stack

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    TStack.shared.delegate = self
    TStack.shared.registerRoute([
        "nativePage1": { NativePage1ViewController() }
    ])

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

extension AppDelegate {
    var rootViewController: UIViewController {
        get {
            return window.rootViewController ?? UIApplication.shared.keyWindow!.rootViewController!
        }
    }

    func findController(_ controller: UIViewController) -> UIViewController {
        if let presented = controller.presentedViewController {
            return findController(presented)
        }
        if let top = (controller as? UINavigationController)?.topViewController {
            return findController(top)
        }
        if let selected = (controller as? UITabBarController)?.selectedViewController {
            return findController(selected)
        }
        return controller
    }
}

extension AppDelegate: TStackDelegate {
    func findCurrentController() -> UIViewController {
        return findController(rootViewController)
    }
}
