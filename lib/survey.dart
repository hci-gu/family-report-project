import 'package:flutter/material.dart';

class SurveyForm extends StatelessWidget {
  final String surveyResponsePersonName;

  SurveyForm(this.surveyResponsePersonName);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Form"),
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(30, 30, 30, 15),
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
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 30, top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => SurveyForm(familyMemberName)),
                    // );
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "Start",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
