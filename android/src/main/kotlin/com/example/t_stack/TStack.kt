package com.example.t_stack

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

object TStack {
    const val kEngineId = "t_stack_engine"

    internal var appContext: Context? = null
    lateinit var flutterEngine: FlutterEngine

    fun init(context: Context) {
        if (appContext == null) {
            appContext = context.applicationContext
            flutterEngine = FlutterEngine(context).also {
                it.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
                FlutterEngineCache.getInstance().put(kEngineId, it)
            }
        }
    }

    fun registerRoute(routeMap: Map<String, Class<out Activity>>) =
        TNavigator.registerRoute(routeMap)
}