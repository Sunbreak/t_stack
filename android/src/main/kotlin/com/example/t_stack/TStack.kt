package com.example.t_stack

import android.app.Activity
import android.content.Context

object TStack {
    internal var appContext: Context? = null

    fun init(context: Context) {
        if (appContext == null) {
            appContext = context.applicationContext
        }
    }

    fun registerRoute(routeMap: Map<String, Class<out Activity>>) =
        TNavigator.registerRoute(routeMap)
}