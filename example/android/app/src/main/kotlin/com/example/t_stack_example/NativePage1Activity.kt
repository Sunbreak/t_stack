package com.example.t_stack_example

import android.app.Activity
import android.os.Bundle
import android.view.View
import com.example.t_stack.TStack

class NativePage1Activity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_page1)

        findViewById<View>(R.id.push_flutter_1).setOnClickListener {
            TStack.pushRoute("flutterPage1")
            startActivity(intent)
        }

        findViewById<View>(R.id.push_flutter_2).setOnClickListener {
            TStack.pushRoute("flutterPage2")
            startActivity(intent)
        }
    }
}