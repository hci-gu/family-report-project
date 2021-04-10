import 'package:family_report_project/regulargreenbutton.dart';
import 'package:family_report_project/survey/surveyusage.dart';
import 'package:flutter/material.dart';

class SurveyForm extends StatelessWidget {
  final String surveyResponsePersonName;

  SurveyForm(this.surveyResponsePersonName);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Survey Form",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
          child: Column(
            children: [
              Text(
                "Screen Time Info Survey",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  "Provide your responses to questions based on your knowledge about.",
                  style: TextStyle(
                    fontSize: height / 30,
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(12.0),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Note",
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Please be truthful about your responses. They will help us immensely in our study.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              RegularGreenButton("Start", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SurveyUsage(
                          familyMemberName: surveyResponsePersonName)),
                );
              }),
            ],
          )),
    );
  }
}
