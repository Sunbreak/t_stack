import 'dart:async';

import 'package:flutter/widgets.dart';

import 'src/t_channel.dart';
import 'src/t_entity.dart';

export 'src/t_entity.dart';
export 'src/t_stack_app.dart';

const String kMethodActionToNative = "methodActionToNative";

const String kActionPush = "push";
const String kActionPop = "pop";

typedef TRouteBuilder = WidgetBuilder Function(TNode node);

class TStack {
  static final Map<String, TRouteBuilder> _routeBuilders = {};

  static void init(Map<String, TRouteBuilder> routeBuilders) {
    WidgetsFlutterBinding.ensureInitialized();
    TChannel.instance.init();
    _routeBuilders.addAll(routeBuilders);
  }

  static TRouteBuilder getRouteBuilder(routeName) => _routeBuilders[routeName]!;

  static Future<void> push(String routeName) async {
    await TChannel.instance.invokeActionToNative({
      'action': kActionPush,
      'routeName': routeName,
    });
  }

  static Future<void> pop() async {
    await TChannel.instance.invokeActionToNative({
      'action': kActionPop,
    });
  }
}
