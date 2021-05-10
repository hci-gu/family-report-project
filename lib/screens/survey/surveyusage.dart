import './surveypickup.dart';
import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import '../../models/model.dart';

class SurveyUsage extends StatefulWidget {
  final FamilyMember familyMember;
  final String currentLoggedInUserUid;
  final String familyId;
  SurveyUsage(
      {Key key, this.familyMember, this.familyId, this.currentLoggedInUserUid})
      : super(key: key);

  @override
  _SurveyUsageState createState() => _SurveyUsageState();
}

class _SurveyUsageState extends State<SurveyUsage> {
  double _currentSliderValue = 0;

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
        title: Text("Survey - Usage",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: Text(
                "How much time in a day do you think ${widget.familyMember.name} spends on ${(widget.familyMember.gender == "Female") ? "her" : "his"} smartphone?",
                style: TextStyle(
                  fontSize: height / 30,
                ),
              ),
            ),
            Spacer(),
            Container(
              child: Text(
                "${(_currentSliderValue ~/ 60)} Hour, ${(_currentSliderValue % 60).toInt()} Minutes",
                style: TextStyle(
                    fontSize: width / 15,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context)
                  .copyWith(showValueIndicator: ShowValueIndicator.never),
              child: Slider(
                value: _currentSliderValue,
                min: 0,
                max: 1440,
                divisions: 96,
                activeColor: Theme.of(context).primaryColor,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(
                    () {
                      _currentSliderValue = value;
                    },
                  );
                },
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: RegularGreenButton(
                "Continue",
                () {
                  var tempSurvey = {
                    widget.familyMember.id: {
                      "Smartphone Usage": "",
                      "Smartphone Pickups": "",
                      "Smartphone work/leisure usage": ""
                    }
                  };
                  tempSurvey[widget.familyMember.id]["Smartphone Usage"] =
                      _currentSliderValue.toString();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurveyPickup(
                        familyMember: widget.familyMember,
                        familyId: widget.familyId,
                        currentLoggedInUserUid: widget.currentLoggedInUserUid,
                        tempSurvey: tempSurvey,
                      ),
                    ),
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
