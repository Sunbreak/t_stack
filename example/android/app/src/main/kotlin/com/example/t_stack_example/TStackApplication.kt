package com.example.t_stack_example

import android.app.Application
import com.example.t_stack.TStack

class TStackApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        TStack.init(this)
        TStack.registerRoute(
            mapOf(
                "nativePage1" to NativePage1Activity::class.java
            )
        )
    }
}