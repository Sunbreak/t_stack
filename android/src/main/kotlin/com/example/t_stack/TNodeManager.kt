package com.example.t_stack

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

object TNodeManager {
    private val nodeGroups = mutableListOf<MutableList<TNode>>()

    fun putIfAbsent(node: TNode) {
        val findGroup = nodeGroups.findLast { group ->
            group.any { it.id == node.id }
        }
        if (findGroup == null) {
            val lastGroup = nodeGroups.lastOrNull()
            if (lastGroup?.last()?.type == node.type) {
                lastGroup.add(node)
            } else {
                nodeGroups.add(mutableListOf(node))
            }
        }
    }
}