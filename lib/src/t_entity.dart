class TNode {
  // final String identifier;

  final String routeName;

  TNode.fromMap(Map<String, dynamic> map)
      // : identifier = map['identifier'],
      : routeName = map['routeName'];

  Map<String, dynamic> toMap() => {
        // 'identifier': identifier,
        'routeName': routeName,
      };
}
