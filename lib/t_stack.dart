
import 'dart:async';

import 'package:flutter/services.dart';

class TStack {
  static const MethodChannel _channel =
      const MethodChannel('t_stack');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
