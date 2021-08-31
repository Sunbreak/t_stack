import UIKit
import Flutter

// TODO SimpleTFlutterViewController
public class TFlutterViewController: FlutterViewController {
    var node: TNode!

    public convenience init(routeName: String) {
        self.init(engine: TStack.shared.flutterEngine, nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
        self.node = TNode(id: UUID().uuidString, routeName: routeName, type: kTypeFlutter)
    }

    public override func viewDidLoad() {
        attachToEngine()
        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        attachToEngine()
        TNodeManager.shared.putIfAbsent(node)
        SwiftTStackPlugin.shared.activateFlutterNode(node)
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
