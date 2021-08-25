package com.example.t_stack

import android.app.Activity
import android.content.Intent

internal object TNavigator {
    private val routeMap: MutableMap<String, Class<out Activity>> = mutableMapOf()

    fun registerRoute(routeMap: Map<String, Class<out Activity>>) {
        this.routeMap.putAll(routeMap)
    }

    fun pushRoute(routeName: String) {
        val clazz = routeMap[routeName] ?: return
        TStack.appContext!!.startActivity(Intent(TStack.appContext, clazz))
    }
}