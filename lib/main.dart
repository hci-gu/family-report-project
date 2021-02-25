import 'package:flutter/material.dart';
import './onboarding.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Family Report App",
      theme: ThemeData(
          primaryColor: const Color(0xff2B9797),
          accentColor: const Color(0xffD2E5E5)),
      home: Onboarding(),
    );
  }
}
