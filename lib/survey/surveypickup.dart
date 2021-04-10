import 'package:family_report_project/survey/surveywl.dart';
import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';

class SurveyPickup extends StatelessWidget {
  final String familyMemberName;
  SurveyPickup(this.familyMemberName);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Question #2")),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: Text(
                "How many times does $familyMemberName pick up his/her smartphone in a day?",
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
                        builder: (context) => SurveyWL(familyMemberName)),
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
