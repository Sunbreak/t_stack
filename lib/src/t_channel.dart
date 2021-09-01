import 'package:flutter/services.dart';
import 'package:t_stack/t_stack.dart';

const String kMethodActionToFlutter = 'methodActionToFlutter';

const String kActionActivate = "activate";
const String kActionRemove = "remove";

final MethodChannel _channel = const MethodChannel('t_stack');

class TChannel {
//# region singleton

  static final _instance = TChannel._();

  static TChannel get instance => _instance;

  TChannel._();

//# endregion

  TStackAppState? _stackAppState;

  void init() {
    _channel.setMethodCallHandler((MethodCall call) async {
      _ensureStackAppState();
      if (call.method == kMethodActionToFlutter) {
        handMethodActionToFlutter(call.arguments);
      }
    });
  }

  void _ensureStackAppState() {
    _stackAppState ??=
        overlayKey.currentContext?.findAncestorStateOfType<TStackAppState>();
  }

  Future<dynamic> handMethodActionToFlutter(Map arguments) async {
    switch (arguments['action']) {
      case kActionActivate:
        final map = arguments['node'].cast<String, dynamic>();
        _stackAppState!.handleActivate(TNode.fromMap(map));
        break;
      case kActionRemove:
        // TODO
        break;
    }
  }

  Future<dynamic> invokeActionToNative([dynamic argments]) =>
      _channel.invokeMethod(kMethodActionToNative, argments);
}
