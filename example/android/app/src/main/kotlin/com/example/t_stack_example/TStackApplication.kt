package com.example.t_stack_example

import android.app.Activity
import android.app.Application
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.ShortcutInfo
import android.content.pm.ShortcutManager
import android.os.Build
import androidx.annotation.RequiresApi
import com.example.t_stack.TStack

const val initialRoute = "flutterPage1"

class TStackApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        TStack.init(this)
        TStack.registerRoute(
            mapOf(
                "nativePage1" to NativePage1Activity::class.java,
                "nativePage2" to NativePage2Activity::class.java
            )
        )

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            initShortcuts()
        }
    }

    @RequiresApi(Build.VERSION_CODES.N_MR1)
    private fun initShortcuts() {
        val shortcutManager = getSystemService(Context.SHORTCUT_SERVICE) as ShortcutManager

        val infos = TShortcut.values().map { it.buildInfo(this) }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            infos.forEach { requestPinShortcut(shortcutManager, it) }
        }
        shortcutManager.addDynamicShortcuts(infos)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun requestPinShortcut(shortcutManager: ShortcutManager, shortcutInfo: ShortcutInfo) {
        if (shortcutManager.isRequestPinShortcutSupported && shortcutManager.pinnedShortcuts.isEmpty()) {
            val resultIntent = shortcutManager.createShortcutResultIntent(shortcutInfo)
            val callbackIntent = PendingIntent.getBroadcast(this, 0, resultIntent, 0)
            shortcutManager.requestPinShortcut(shortcutInfo, callbackIntent.intentSender)
        }
    }
}

enum class TShortcut(
    private val type: String,
    private val clz: Class<out Activity>,
    private val title: String? = null
) {
    Native1("native1", NativePage1Activity::class.java);

    @RequiresApi(Build.VERSION_CODES.N_MR1)
    fun buildInfo(context: Context): ShortcutInfo {
        val intent = Intent(context, clz).setAction(Intent.ACTION_VIEW)
        return ShortcutInfo.Builder(context, type)
            .setIntent(intent)
            .setShortLabel(title ?: type).build()
    }
}