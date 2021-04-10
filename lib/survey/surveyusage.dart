import 'package:family_report_project/survey/surveypickup.dart';
import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';

class SurveyUsage extends StatefulWidget {
  final String familyMemberName;
  SurveyUsage({Key key, this.familyMemberName}) : super(key: key);

  @override
  _SurveyUsageState createState() => _SurveyUsageState();
}

class _SurveyUsageState extends State<SurveyUsage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Question #1")),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: Text(
                "For how many hours does $widget.familyMemberName use his/her smartphone in a day?",
                style: TextStyle(
                  fontSize: height / 30,
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: RegularGreenButton(
                "Continue",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SurveyPickup(widget.familyMemberName)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
