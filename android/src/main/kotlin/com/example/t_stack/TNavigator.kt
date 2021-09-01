package com.example.t_stack

import android.app.Activity
import android.app.Application
import android.content.Intent
import android.os.Bundle
import java.util.*

object TNavigator : Application.ActivityLifecycleCallbacks {
    private val routeMap: MutableMap<String, Class<out Activity>> = mutableMapOf()

    fun registerRoute(routeMap: Map<String, Class<out Activity>>) {
        this.routeMap.putAll(routeMap)
    }

    fun pushRoute(routeName: String) {
        val clazz = routeMap[routeName]
        if (clazz != null) {
            val node = TNode(UUID.randomUUID().toString(), routeName, kTypeNative)
            TNodeManager.putIfAbsent(node)
            val intent = Intent(TStack.appContext, clazz).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            // Ensure onActivityCreated/onActivityDestroyed findLastGroup(node)
            intent.putExtra(kTNode, node)
            TStack.appContext!!.startActivity(intent)
        } else {
            val node = TNode(UUID.randomUUID().toString(), routeName, kTypeFlutter)
            TNodeManager.putIfAbsent(node)
            TStack.flutterEngine.getTStackPlugin().activateFlutterNode(node)
        }
    }

    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) = Unit

    override fun onActivityDestroyed(activity: Activity) = Unit

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) = Unit

    override fun onActivityPostCreated(activity: Activity, savedInstanceState: Bundle?) {
        activity.intent.getParcelableExtra<TNode>(kTNode)?.also { node ->
            // Before created, TNode within activity should be in TNode groups
            TNodeManager.findLastGroup(node)!!.activities.add(activity)
        }
    }

    override fun onActivityPreDestroyed(activity: Activity) {
        activity.intent.getParcelableExtra<TNode>(kTNode)?.also { node ->
            // Before destroyed, TNode within activity could be removed already
            TNodeManager.findLastGroup(node)?.also { group ->
                group.activities.remove(activity)
                group.remove(node)
            }
        }
    }

    override fun onActivityStarted(activity: Activity) = Unit

    override fun onActivityStopped(activity: Activity) = Unit

    override fun onActivityResumed(activity: Activity) = Unit

    override fun onActivityPaused(activity: Activity) = Unit
}