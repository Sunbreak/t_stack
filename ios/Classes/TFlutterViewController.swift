import UIKit
import Flutter

// TODO SimpleTFlutterViewController
public class TFlutterViewController: FlutterViewController {
    var routeName: String!

    public convenience init(routeName: String) {
        self.init(engine: TStack.shared.flutterEngine, nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
        self.routeName = routeName
    }

    public override func viewDidLoad() {
        attachToEngine()
        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        SwiftTStackPlugin.shared.pushRoute(routeName)
        attachToEngine()
        super.viewWillAppear(animated)
    }

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            completion?()
            self.detachToEngine()
        }
    }
}

extension TFlutterViewController {
    func attachToEngine() {
        if TStack.shared.flutterEngine.viewController != self {
            TStack.shared.flutterEngine.viewController = self
        }
    }

    func detachToEngine() {
        if TStack.shared.flutterEngine.viewController == self {
            TStack.shared.flutterEngine.viewController = nil
        }
    }
}
