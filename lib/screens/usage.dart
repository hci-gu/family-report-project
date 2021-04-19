import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
import 'package:app_usage/app_usage.dart';

class UsageData extends StatefulWidget {
  @override
  _UsageDataState createState() => _UsageDataState();
}

class _UsageDataState extends State<UsageData> {
  var totalDuration = new Duration(hours: 0, minutes: 0, seconds: 0);
  var weeklyAvgDuration = new Duration(hours: 0, minutes: 0, seconds: 0);
  List<AppUsageInfo> events = [];
  DateTime peakUsageDateTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initUsage();
    });
  }

  Future<void> initUsage() async {
    UsageStats.grantUsagePermission();
    try {
      DateTime startDate = new DateTime.now().subtract(Duration(days: 1));
      DateTime endDate = new DateTime.now();
      List<AppUsageInfo> infos;
      Duration calcDuration = new Duration(hours: 0, minutes: 0, seconds: 0);
      Duration weekDuration = new Duration(hours: 0, minutes: 0, seconds: 0);
      Duration weekDurationAverage;

      for (int j = 0; j < 7; j++) {
        startDate = DateTime.now().subtract(Duration(days: j + 1));
        endDate = DateTime.now().subtract(Duration(days: j));
        infos = await AppUsage.getAppUsage(startDate, endDate);
        for (int i = 0; i < infos.length; i++) {
          calcDuration = calcDuration + infos[i].usage;
        }
        weekDuration = weekDuration + calcDuration;
      }
      weekDurationAverage = weekDuration ~/ 7;

      startDate = DateTime.now().subtract(Duration(days: 1));
      endDate = DateTime.now();
      infos = await AppUsage.getAppUsage(startDate, endDate);
      for (int i = 0; i < infos.length; i++) {
        calcDuration = calcDuration + infos[i].usage;
      }

      this.setState(
        () {
          events = infos.reversed.toList();
          totalDuration = calcDuration;
          weeklyAvgDuration = weekDurationAverage;
        },
      );
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Usage Stats"),
        ),
        body: Column(
          children: <Widget>[
            Text("the total screentime is - $totalDuration"),
            Text("the weekly average screentime is - $weeklyAvgDuration"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            initUsage();
          },
          child: Icon(
            Icons.refresh,
          ),
          mini: true,
        ),
      ),
    );
  }
}
