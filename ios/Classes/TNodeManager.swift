let kTNode = "node"
let kTypeFlutter = 0
let kTypeNative = 1

struct TNode {
    let id: String
    let routeName: String
    let type: Int

    func toDictionary() -> Dictionary<String, Any> {
        return [
            "id": id,
            "routeName": routeName,
            "type": type
        ]
    }
}

class TNodeManager {
    static let shared = TNodeManager()

    private init() {}

    private var nodeGroups = Array<[TNode]>();

    func putIfAbsent(_ node: TNode) {
        let findGroup = nodeGroups.last { group in
            return group.contains { $0.id == node.id }
        }
        if (findGroup == nil) {
            var lastGroup = nodeGroups.last
            if (lastGroup?.last?.type == node.type) {
                lastGroup!.append(node)
            } else {
                nodeGroups.append([node])
            }
        }
    }
}
