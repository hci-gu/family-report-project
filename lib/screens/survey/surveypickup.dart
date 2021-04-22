import './surveywl.dart';
import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import '../../models/model.dart';

class SurveyPickup extends StatefulWidget {
  final FamilyMember familyMember;
  final String currentLoggedInUserUid;
  final String familyId;
  final Map<String, Map<String, String>> tempSurvey;
  SurveyPickup(
      {Key key,
      this.familyMember,
      this.currentLoggedInUserUid,
      this.familyId,
      this.tempSurvey})
      : super(key: key);

  @override
  _SurveyPickupState createState() => _SurveyPickupState();
}

class _SurveyPickupState extends State<SurveyPickup> {
  double _currentSliderValue = 0;
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
                "How many times does ${widget.familyMember.name} pick up ${(widget.familyMember.gender == "female") ? "her" : "his"} smartphone in a day?",
                style: TextStyle(
                  fontSize: height / 30,
                ),
              ),
            ),
            Spacer(),
            Container(
              child: Text(
                "${_currentSliderValue.toInt()} Pickups",
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
                max: 400,
                divisions: 400,
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
                  widget.tempSurvey[widget.familyMember.id]
                      ["Smartphone Pickups"] = _currentSliderValue.toString();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SurveyWL(
                              familyMember: widget.familyMember,
                              tempSurvey: widget.tempSurvey,
                              familyId: widget.familyId,
                              currentLoggedInUserUid:
                                  widget.currentLoggedInUserUid,
                            )),
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
