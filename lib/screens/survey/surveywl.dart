import './../homescreen.dart';
import 'package:flutter/material.dart';
import './../regulargreenbutton.dart';
import '../../models/model.dart';
import '../../services/database.dart';

enum SmartphoneUsageType { work, leisure }

class SurveyWL extends StatefulWidget {
  final FamilyMember familyMember;
  final String currentLoggedInUserUid;
  final String familyId;
  final Map<String, Map<String, String>> tempSurvey;

  SurveyWL(
      {Key key,
      this.familyMember,
      this.currentLoggedInUserUid,
      this.familyId,
      this.tempSurvey})
      : super(key: key);

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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        title: Text("Experience Jar - Work/Leisure",
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
                "For what purpose do you think ${widget.familyMember.name} mostly uses ${(widget.familyMember.gender == "female") ? "her" : "his"} smartphone for?",
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
                    setState(
                      () {
                        _character = value;
                      },
                    );
                  },
                ),
              ],
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
              child: RegularGreenButton(
                "Finish Survey",
                () async {
                  widget.tempSurvey[widget.familyMember.id]
                          ["Smartphone work/leisure usage"] =
                      (_character == SmartphoneUsageType.leisure)
                          ? "leisure"
                          : "work";

                  DatabaseService(widget.familyId,
                          uid: widget.currentLoggedInUserUid)
                      .updateFamilyMemberSurveyResponses(
                          widget.tempSurvey, widget.familyMember.id);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          familyId: widget.familyId,
                          loggedInUserUid: widget.currentLoggedInUserUid,
                        ),
                      ),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
