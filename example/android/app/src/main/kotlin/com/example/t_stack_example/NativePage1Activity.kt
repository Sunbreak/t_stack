package com.example.t_stack_example

import android.app.Activity
import android.os.Bundle
import android.view.View
import com.example.t_stack.TFlutterActivity
import com.example.t_stack.kRouteName

class NativePage1Activity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_page1)

        findViewById<View>(R.id.push_flutter_1).setOnClickListener {
            val intent = TFlutterActivity.newIntentBuilder().build(this)
            intent.putExtra(kRouteName, "flutterPage1")
            startActivity(intent)
        }
    }
}