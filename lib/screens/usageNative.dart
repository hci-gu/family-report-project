import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsageNative extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UsageNative> {
  static const platform =
      const MethodChannel('familyreportproject.totalscreetime');
  double _totalUsageData = 0.0;

  Future<void> _getUsageData() async {
    double totalUsageData;
    try {
      totalUsageData = await platform.invokeMethod('getUsageData');
    } on PlatformException catch (e) {
      print(e);
      totalUsageData = 1.0;
    }

    setState(() {
      _totalUsageData = totalUsageData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Usage Data'),
              onPressed: _getUsageData,
            ),
            Text(_totalUsageData.toString()),
          ],
        ),
      ),
    );
  }
}
