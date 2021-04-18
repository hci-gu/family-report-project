import './surveypickup.dart';
import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import '../../models/model.dart';

class SurveyUsage extends StatefulWidget {
  final FamilyMember familyMember;
  SurveyUsage({Key key, this.familyMember}) : super(key: key);

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
      appBar: AppBar(title: Text("Question #1")),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: Text(
                "For how many hours does in a day does ${widget.familyMember.name} use ${(widget.familyMember.gender == "female") ? "her" : "his"} smartphone?",
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
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
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
                            SurveyPickup(familyMember: widget.familyMember)),
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
