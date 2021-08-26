let kEngineId = "t_stack_engine"

public class TStack {
    static public let shared = TStack()

    private init() {}

    public lazy var flutterEngine = FlutterEngine(name: kEngineId)

    var running = false

    public func initialize() {
        if (!running) {
            running = flutterEngine.run()
        }
    }

    public func registerRoute(_ routeMap: Dictionary<String, () -> UIViewController>) {
        TNavigator.shared.registerRoute(routeMap)
    }
}
