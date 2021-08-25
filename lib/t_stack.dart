import 'dart:async';

import 'package:flutter/services.dart';

const String kMethodActionToNative = "methodActionToNative";

const String kActionPush = "push";

class TStack {
  static const MethodChannel _channel = const MethodChannel('t_stack');

  static Future<void> push(String routeName) async {
    await _channel.invokeMethod(kMethodActionToNative, {
      'routeName': routeName,
      'action': kActionPush,
    });
  }
}
