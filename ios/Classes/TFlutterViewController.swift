import UIKit

// TODO SimpleTFlutterViewController
public class TFlutterViewController: FlutterViewController {
    convenience init() {
        self.init(engine: TStack.shared.flutterEngine, nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        attachToEngine()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        attachToEngine()
    }

    public override func didMove(toParent parent: UIViewController?) {
        if parent == nil {
            detachToEngine()
        }
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
