package com.example.t_stack_example

import android.app.Activity
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import com.example.t_stack.TFlutterActivity

class EntryActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Handler(Looper.getMainLooper()).postDelayed({
            val intent = TFlutterActivity.newIntentBuilder()
                .routeName(initialRoute)
                .build(this)
            startActivity(intent)
            finish()
        }, 500) // FIXME
    }
}
