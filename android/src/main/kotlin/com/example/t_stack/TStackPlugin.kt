package com.example.t_stack

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

const val kMethodActionToNative = "methodActionToNative"
const val kMethodActionToFlutter = "methodActionToFlutter"

const val kActionPush = "push"
const val kActionActivate = "activate"
const val kActionPop = "pop"
const val kActionRemove = "Remove"

/** TStackPlugin */
class TStackPlugin : FlutterPlugin, MethodCallHandler {
  companion object {
    val instance get() = TStack.flutterEngine.plugins[TStackPlugin::class.java] as TStackPlugin
  }

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "t_stack")
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == kMethodActionToNative) {
      val args = call.arguments as Map<String, Any>
      when (args["action"] as String) {
        kActionPush -> {
          handleFlutterPush(args)
        }
        kActionPop -> {
          handleFlutterPop()
        }
        else -> println("Unknown") // TODO warning
      }
      result.success(null)
    } else {
      result.notImplemented()
    }
  }

  private fun handleFlutterPush(args: Map<String, Any>) {
    TNavigator.pushRoute(args["routeName"] as String)
  }

  private fun handleFlutterPop() {
    TNodeManager.pop()
  }

  fun activateFlutterNode(node: TNode) {
    channel.invokeMethod(
      kMethodActionToFlutter, mapOf(
        "action" to kActionActivate,
        kTNode to node.toMap()
      )
    )
  }

  fun removeFlutterNodes(node: TNode) {
    channel.invokeMethod(
      kMethodActionToFlutter, mapOf(
        "action" to kActionRemove,
        kTNode to node
      )
    )
  }
}
