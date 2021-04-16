import './../homescreen.dart';
import 'package:flutter/material.dart';
import './../regulargreenbutton.dart';

enum SmartphoneUsageType { work, leisure }

class SurveyWL extends StatefulWidget {
  final String familyMemberName;
  SurveyWL({Key key, this.familyMemberName}) : super(key: key);

  @override
  _SurveyWLState createState() => _SurveyWLState();
}

class _SurveyWLState extends State<SurveyWL> {
  SmartphoneUsageType _character = SmartphoneUsageType.leisure;
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
                "For what purpose do you think ${widget.familyMemberName} mostly uses his/her smartphone?",
                style: TextStyle(
                  fontSize: height / 30,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                RadioListTile<SmartphoneUsageType>(
                  title: const Text('For leisure'),
                  value: SmartphoneUsageType.leisure,
                  groupValue: _character,
                  onChanged: (SmartphoneUsageType value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                RadioListTile<SmartphoneUsageType>(
                  title: const Text('For work'),
                  value: SmartphoneUsageType.work,
                  groupValue: _character,
                  onChanged: (SmartphoneUsageType value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: RegularGreenButton(
                "Finish Survey",
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
