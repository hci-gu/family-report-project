import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
import 'package:app_usage/app_usage.dart';
import './../services/database.dart';

class UsageData extends StatefulWidget {
  final String familyId;
  final String familyMemberUid;

  UsageData({Key key, this.familyId, this.familyMemberUid}) : super(key: key);
  @override
  _UsageDataState createState() => _UsageDataState();
}

class _UsageDataState extends State<UsageData> {
  var totalDuration = new Duration(hours: 0, minutes: 0, seconds: 0);
  List<AppUsageInfo> events = [];

  Map<String, double> _lastTwoWeekUsage;
  Map<String, List<double>> _lastTwoWeekUsageBreakdown;

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
      DateTime now = new DateTime.now();
      DateTime currentDate = new DateTime(now.year, now.month, now.day);
      DateTime dayBeforeDate, startHour, endHour;
      List<AppUsageInfo> infos;
      Map<String, double> lastTwoWeekUsage;
      Map<String, List<double>> lastTwoWeekUsageBreakdown;
      Duration calcDuration = new Duration(hours: 0, minutes: 0, seconds: 0);

      //find last 2 weeks daily usage and store it in a map
      for (int j = 0; j < 14; j++) {
        currentDate = currentDate.subtract(Duration(days: j));
        dayBeforeDate = currentDate.subtract(Duration(days: j + 1));
        infos = await AppUsage.getAppUsage(currentDate, dayBeforeDate);

        for (int i = 0; i < infos.length; i++) {
          calcDuration = calcDuration + infos[i].usage;
        }

        lastTwoWeekUsage[dayBeforeDate.day.toString()] =
            calcDuration.inHours.toDouble() +
                calcDuration.inMinutes.toDouble() / 60;

        calcDuration =
            Duration(hours: 0, minutes: 0, seconds: 0); //reset variable

        for (int k = 0; k < 24; k++) {
          startHour = DateTime(now.year, now.month, now.day);
          endHour = startHour.subtract(Duration(hours: k + 1));
          infos = await AppUsage.getAppUsage(startHour, endHour);

          for (int i = 0; i < infos.length; i++) {
            calcDuration = calcDuration + infos[i].usage;
          }

          lastTwoWeekUsageBreakdown[dayBeforeDate.day.toString()].add(
              calcDuration.inHours.toDouble() +
                  calcDuration.inMinutes.toDouble() / 60);

          calcDuration =
              Duration(hours: 0, minutes: 0, seconds: 0); //reset variable
        }
      }

      await DatabaseService(widget.familyId, uid: widget.familyMemberUid)
          .updateFamilyMemberScreenTimeData(
              lastTwoWeekUsage, lastTwoWeekUsageBreakdown);

      this.setState(
        () {
          _lastTwoWeekUsage = lastTwoWeekUsage;
          _lastTwoWeekUsageBreakdown = lastTwoWeekUsageBreakdown;
          events = infos.reversed.toList();
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
            Text("the total screentime is - $_lastTwoWeekUsage"),
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
