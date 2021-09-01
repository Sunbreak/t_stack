package com.example.t_stack

import android.app.Activity
import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

const val kTNode = "node"
const val kTypeFlutter = 0
const val kTypeNative = 1

@Parcelize
class TNode(
    val id: String,
    val routeName: String,
    val type: Int
) : Parcelable {
    fun toMap() = mapOf(
        "id" to id,
        "routeName" to routeName,
        "type" to type
    )
}

class TActivityGroup(nodes: MutableList<TNode>) : MutableList<TNode> by nodes {
    // TODO WeakReference
    val activities = mutableListOf<Activity>()
}

object TNodeManager {
    private val nodeGroups = mutableListOf<TActivityGroup>()

    fun findLastGroup(node: TNode) = nodeGroups.findLast { group ->
        group.any { it.id == node.id }
    }

    fun putIfAbsent(node: TNode) {
        if (findLastGroup(node) != null) return

        val lastGroup = nodeGroups.lastOrNull()
        if (lastGroup?.last()?.type == node.type) {
            lastGroup.add(node)
        } else {
            nodeGroups.add(TActivityGroup(mutableListOf(node)))
        }
    }

    fun pop() {
        val lastGroup = nodeGroups.last()
        val lastNode = lastGroup.last()

        if (lastNode.type == kTypeNative // native popTo native/flutter or OUTSIDE
            || lastGroup.size == 1 // last flutter popTo native or OUTSIDE
        ) {
            // node/activity and group will be remove in onActivityDestroyed
            lastGroup.activities.last {
                it.intent.getParcelableExtra<TNode>(kTNode)!!.id == lastNode.id
            }.finish()
        } else {
            // flutter popTo flutter
            val preNode = lastGroup[lastGroup.lastIndex - 1]
            lastGroup.remove(lastNode)
            TStackPlugin.instance.removeFlutterNodes(lastNode)
            TStackPlugin.instance.activateFlutterNode(preNode)
        }
    }

    fun clearGroup() {
        nodeGroups.removeAll { it.isEmpty() }
    }
}