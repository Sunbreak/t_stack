import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../t_stack.dart';

final GlobalKey<OverlayState> overlayKey = GlobalKey<OverlayState>();

class TStackApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TStackAppState();
}

class TStackAppState extends State<TStackApp> {
  final Map<String, PageHolder> _pageHolders = {};

  PageHolder? _currentHolder;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Overlay(
        key: overlayKey,
      ),
    );
  }

  void pushNode(TNode node) {
    // var holder = _pageHolders[node.identifier];
    var holder = _pageHolders[node.routeName];
    if (holder != null) {
      holder.widget.remove(); // remove widget in stack
    } else {
      holder = PageHolder.of(node);
    }
    // insert widget onto top
    overlayKey.currentState?.insert(holder.widget);
    _currentHolder = holder;

    this.setState(() {});
  }
}

class PageHolder {
  final TNode node;
  final OverlayEntry widget;

  PageHolder.of(this.node)
      : widget =
            OverlayEntry(builder: TStack.getRouteBuilder(node.routeName)(node));
}
