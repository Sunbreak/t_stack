public protocol TStackDelegate {
    func findCurrentController() -> UIViewController;
}

public class TStack {
    static public let shared = TStack()

    private init() {}

    public var delegate: TStackDelegate!

    public func registerRoute(_ routeMap: Dictionary<String, () -> UIViewController>) {
        TNavigator.shared.registerRoute(routeMap)
    }
}
