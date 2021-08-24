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
        TStack.shared.delegate.findCurrentController().present(block(), animated: true)
    }
}
