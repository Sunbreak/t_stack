package com.example.t_stack

import android.app.Activity
import android.content.Intent
import java.util.*

internal object TNavigator {
    private val routeMap: MutableMap<String, Class<out Activity>> = mutableMapOf()

    fun registerRoute(routeMap: Map<String, Class<out Activity>>) {
        this.routeMap.putAll(routeMap)
    }

    fun pushRoute(routeName: String) {
        val clazz = routeMap[routeName]
        if (clazz != null) {
            TNodeManager.putIfAbsent(TNode(UUID.randomUUID().toString(), routeName, kTypeNative))
            val intent = Intent(TStack.appContext, clazz).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            TStack.appContext!!.startActivity(intent)
        } else {
            val node = TNode(UUID.randomUUID().toString(), routeName, kTypeFlutter)
            TNodeManager.putIfAbsent(node)
            TStack.flutterEngine.getTStackPlugin().activateFlutterNode(node)
        }
    }
}