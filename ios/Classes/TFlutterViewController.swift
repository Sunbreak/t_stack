import UIKit
import Flutter

// TODO SimpleTFlutterViewController
public class TFlutterViewController: FlutterViewController {
    var rootNode: TNode!

    public convenience init(routeName: String) {
        self.init(engine: TStack.shared.flutterEngine, nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
        self.rootNode = TNode(id: UUID().uuidString, routeName: routeName, type: kTypeFlutter)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        attachToEngine()
        TNodeManager.shared.putIfAbsent(rootNode)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        attachToEngine()
        let topNode = TNodeManager.shared.findLastGroup(rootNode)!.last!
        SwiftTStackPlugin.shared.activateFlutterNode(topNode)
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
