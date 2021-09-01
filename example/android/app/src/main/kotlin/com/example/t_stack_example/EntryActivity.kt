package com.example.t_stack_example

import android.app.Activity
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import com.example.t_stack.TStack

class EntryActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Handler(Looper.getMainLooper()).postDelayed({
            TStack.pushRoute(initialRoute)
            finish()
        }, 500) // FIXME
    }
}
