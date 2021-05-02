package com.example.family_report_project
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

//import the usage stats manager
import android.app.usage.UsageStatsManager

class MainActivity : FlutterActivity() {
    private val channelName = "familyreportproject.totalscreetime"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
                .setMethodCallHandler {
                        // Note: this method is invoked on the main thread.
                        call,
                        result ->
                    if (call.method == "getUsageData") {
                        val usageData = getUsageData()

                        if (usageData != null) {
                            result.success(usageData)
                        } else {
                            result.error("UNAVAILABLE", "Battery level not available.", null)
                        }
                    } else {
                        result.notImplemented()
                    }
                }
    }

    private fun getUsageData(): Double {
        val totalUsageData = 3.0
        return totalUsageData
    }
}
