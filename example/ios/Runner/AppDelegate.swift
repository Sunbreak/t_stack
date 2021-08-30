import UIKit
import Flutter
import t_stack

let initialRoute = "flutterPage1"

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        TStack.shared.initialize()
        TStack.shared.registerRoute([
            "nativePage1": { NativePage1ViewController() }
        ])

        GeneratedPluginRegistrant.register(with: TStack.shared.flutterEngine)

        self.window = UIWindow(frame: UIScreen.main.bounds)

        initShortcuts()
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            handleShortcut(shortcutItem)
            self.window.makeKeyAndVisible()
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }

        self.window.rootViewController = TFlutterViewController(routeName: initialRoute)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // FIXME
            self.window.makeKeyAndVisible()
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

// MARK: Shortcuts
extension AppDelegate {
    func initShortcuts() {
        if let items = UIApplication.shared.shortcutItems, items.count > 0 {
            return
        }
        UIApplication.shared.shortcutItems = TShortcut.allCases.map { $0.shortcutItem }
    }

    override func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        handleShortcut(shortcutItem)
    }

    func handleShortcut(_ shortcutItem: UIApplicationShortcutItem) {
        let s = TShortcut.allCases.first { $0.rawValue == shortcutItem.type }
        self.window.rootViewController = s!.viewControllerType.init()
    }
}

enum TShortcut: String, CaseIterable {
    case Native1 = "native1"

    var shortcutItem: UIApplicationShortcutItem {
        UIApplicationShortcutItem(type: rawValue, localizedTitle: rawValue)
    }

    var viewControllerType: UIViewController.Type {
        switch self {
        case .Native1: return NativePage1ViewController.self
        }
    }
}
