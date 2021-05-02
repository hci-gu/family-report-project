package com.example.family_report_project;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import android.content.pm.PackageManager;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Calendar;
import android.app.usage.UsageEvents;
import android.app.usage.UsageStatsManager;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "familyreportproject.totalscreetime";

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
  super.configureFlutterEngine(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler(
                    (call, result) -> {
            // Note: this method is invoked on the main thread.
            if (call.method.equals("getUsageData")) {
              double usageData = getUsageData();

              if (usageData != 0.0) {
                result.success(usageData);
              } else {
                result.error("UNAVAILABLE", "Battery level not available.", null);
              }
            } else {


              result.notImplemented();
            }
          }
        );
        
  }

  private double getUsageData() {
    double totalUsageData;

    //define start and end times for usage stats querying
    long next_extract_time = System.currentTimeMillis() - TimeUnit.DAYS.toMillis(1);
    long startTime = next_extract_time;
    long endTime = System.currentTimeMillis();

    UsageEvents usageEvents = usageStatsManager.queryEvents(
      startTime,
      endTime
    );

     // save each event to the raw application log
     long lastEventTime = startTime;
     ArrayList<HashMap<String, String>> rawAppLogDump = new ArrayList<HashMap<String, Integer>>();
     while (usageEvents.hasNextEvent()){
         UsageEvents.Event event = new UsageEvents.Event();
         usageEvents.getNextEvent(event);
         String packageName = event.getPackageName();
         int actionType = event.getEventType();
         long eventTime = event.getTimeStamp();
         Calendar cal = Calendar.getInstance();
         cal.setTimeInMillis(eventTime);
          HashMap<String, String> eventEntry = new HashMap<String, String>();
         PackageManager pm = PackageManager();
         if(pm.getLaunchIntentForPackage(packageName) != null
                 & ((actionType == 1 & usageEvents.hasNextEvent()) || actionType == 2)
                 & eventTime <= next_extract_time) {
                   eventEntry.put("packageName", packageName);
                   eventEntry.put("eventTime", event.getTimeStamp());
                   eventEntry.put("eventTimeHuman", cal.getTime().toString());
                   eventEntry.put("actionType", String.valueOf(actionType));
                   lastEventTime = eventTime;
                   rawAppLogDump.add(eventEntry);
         }
     }
    return 4.0;
  }
}

