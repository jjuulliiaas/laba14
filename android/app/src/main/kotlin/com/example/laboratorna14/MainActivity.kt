package com.example.laboratorna14

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.laboratorna14/time"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getCurrentTime") {
                val currentTime = getCurrentTime()
                result.success(currentTime)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getCurrentTime(): String {
        val sdf = SimpleDateFormat("HH:mm:ss", Locale.getDefault())
        return sdf.format(Date())
    }
}
