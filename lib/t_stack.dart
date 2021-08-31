import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'src/t_channel.dart';
import 'src/t_entity.dart';

export 'src/t_entity.dart';
export 'src/t_stack_app.dart';

const String kMethodActionToNative = "methodActionToNative";

const String kActionPush = "push";
const String kActionActivate = "activate";

typedef TRouteBuilder = WidgetBuilder Function(TNode node);

class TStack {
  static const MethodChannel _channel = const MethodChannel('t_stack');

  static final Map<String, TRouteBuilder> _routeBuilders = {};

  static void init(Map<String, TRouteBuilder> routeBuilders) {
    WidgetsFlutterBinding.ensureInitialized();
    TChannel.instance.init();
    _routeBuilders.addAll(routeBuilders);
  }

  static TRouteBuilder getRouteBuilder(routeName) => _routeBuilders[routeName]!;

  static Future<void> push(String routeName) async {
    await _channel.invokeMethod(kMethodActionToNative, {
      'action': kActionPush,
      'routeName': routeName,
    });
  }
}
