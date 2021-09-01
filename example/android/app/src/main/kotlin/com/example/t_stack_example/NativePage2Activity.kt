package com.example.t_stack_example

import android.app.Activity
import android.os.Bundle
import android.view.View
import com.example.t_stack.TStack

class NativePage2Activity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_page2)
        title = "NativePage2"

        findViewById<View>(R.id.push_flutter_1).setOnClickListener {
            TStack.pushRoute("flutterPage1")
        }

        findViewById<View>(R.id.push_flutter_2).setOnClickListener {
            TStack.pushRoute("flutterPage2")
        }

        findViewById<View>(R.id.push_native_1).setOnClickListener {
            TStack.pushRoute("nativePage1")
        }

        findViewById<View>(R.id.push_native_2).setOnClickListener {
            TStack.pushRoute("nativePage2")
        }

        findViewById<View>(R.id.pop).setOnClickListener {
            TStack.pop()
        }
    }
}