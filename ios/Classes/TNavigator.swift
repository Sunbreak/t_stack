import UIKit

class TNavigator {
    static let shared = TNavigator()

    private init() {}

    private var routeMap: Dictionary<String, () -> UIViewController> = [:]

    func registerRoute(_ routeMap: Dictionary<String, () -> UIViewController>) {
        self.routeMap.merge(routeMap) { $1 }
    }

    func pushRoute(_ routeName: String) {
        guard let block = routeMap[routeName] else { return }
        findController(rootViewController).present(block(), animated: true)
    }

    var rootViewController: UIViewController {
        get {
            UIApplication.shared.delegate?.window??.rootViewController ?? UIApplication.shared.keyWindow!.rootViewController!
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
