package com.example.t_stack

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import io.flutter.embedding.android.FlutterView
import java.util.*

const val kRouteName = "routeName"

// TODO SimpleTFlutterActivity
class TFlutterActivity : FlutterActivity() {
    companion object {
        fun newIntentBuilder(id: String = TStack.kEngineId) =
            com.example.t_stack.CachedEngineIntentBuilder(TFlutterActivity::class.java, id)
    }

    private lateinit var flutterView: FlutterView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flutterView = findFlutterView(window.decorView)!!
    }

    override fun onResume() {
        super.onResume()
        flutterView.attachToFlutterEngine(flutterEngine!!)
        TNodeManager.putIfAbsent(node)
        TStack.flutterEngine.getTStackPlugin().activateFlutterNode(node)
    }

    override fun onPause() {
        super.onPause()
        flutterView.detachFromFlutterEngine()
    }

    override fun onDestroy() {
        val e = flutterEngine!!
        super.onDestroy()
        e.lifecycleChannel.appIsResumed()
    }

    override fun detachFromFlutterEngine() {
        /**
         * Override and do nothing.
         * The idea here is to avoid releasing delegate when
         * a new FlutterActivity is attached in Flutter2.0.
         */
        // super.detachFromFlutterEngine()
    }

    override fun getCachedEngineId() = TStack.kEngineId

    private val node get() = intent.getParcelableExtra<TNode>(kTNode)!!
}

const val kExtraCachedEngineId = "cached_engine_id"
const val kExtraDestroyEngineWithActivity = "destroy_engine_with_activity"
const val kExtraBackgroundMode = "background_mode"

class CachedEngineIntentBuilder(
    private val activityClass: Class<out Activity>,
    private val cachedEngineId: String,
    private val destroyEngineWithActivity: Boolean = false,
    private val backgroundMode: String = FlutterActivityLaunchConfigs.BackgroundMode.opaque.name
) {
    private lateinit var routeName: String

    fun routeName(routeName: String) = apply {
        this.routeName = routeName
    }

    fun build(context: Context) = Intent(context, activityClass)
        .putExtra(kExtraCachedEngineId, cachedEngineId)
        .putExtra(kExtraDestroyEngineWithActivity, destroyEngineWithActivity)
        .putExtra(kExtraBackgroundMode, backgroundMode)
        .putExtra(kTNode, TNode(UUID.randomUUID().toString(), routeName, kTypeFlutter))
}

fun findFlutterView(view: View): FlutterView? {
    if (view is FlutterView) {
        return view
    } else if (view is ViewGroup) {
        for (i in 0..view.childCount) {
            val v = findFlutterView(view.getChildAt(i))
            if (v != null) return v
        }
    }
    return null
}