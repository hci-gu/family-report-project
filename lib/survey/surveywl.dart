import 'package:family_report_project/homescreen.dart';
import 'package:flutter/material.dart';
import './../regulargreenbutton.dart';
import './../homescreen.dart';

class SurveyWL extends StatelessWidget {
  final String familyMemberName;
  SurveyWL(this.familyMemberName);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Question #3")),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: Text(
                "For what purpose do you think $familyMemberName mostly uses his/her smartphone?",
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
                    MaterialPageRoute(builder: (context) => HomeScreen()),
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
