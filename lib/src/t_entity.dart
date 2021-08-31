const kTNode = 'node';
const kTypeFlutter = 0;
const kTypeNative = 1;

class TNode {
  final String id;

  final String routeName;

  final int type;

  TNode(this.id, this.routeName, this.type);

  TNode.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        routeName = map['routeName'],
        type = map['type'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'routeName': routeName,
        'type': type,
      };
}
