import 'package:flutter/material.dart';
import './../models/model.dart';
import 'package:provider/provider.dart';
import 'familymemberwidget.dart';
import './regulargreenbutton.dart';
import './experiencejar/experienceself.dart';
import './pendingResponses.dart';

class FamilyMemberList extends StatefulWidget {
  final String familyId;
  final String currentLoggedInUserUid;
  FamilyMemberList({Key key, this.familyId, this.currentLoggedInUserUid})
      : super(key: key);

  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final familyMemberList = Provider.of<List<FamilyMember>>(context) ?? [];
    bool isAllSurveysFilled = true;
    for (var familyMember in familyMemberList) {
      if (familyMember.isSurveyFilled == false) {
        isAllSurveysFilled = false;
      }
    }
    return Container(
      child: familyMemberList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (isAllSurveysFilled == true)
              ? Column(
                  //experience jar section
                  children: [
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.fromLTRB(width / 30, 0, width / 30, 15),
                      child: Text(
                        "Experience Logging",
                        style: TextStyle(
                            fontSize: height / 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.fromLTRB(width / 30, 0, width / 30, 15),
                      child: Text(
                        "All Surveys Filled, Thank you! We will now proceed with the qualitative study, where you need to spend just 5 mins a day giving your answers to two questions, for two weeks.",
                        style: TextStyle(
                          fontSize: height / 40,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.fromLTRB(width / 30, 0, width / 30, 15),
                      child: RegularGreenButton(
                        "Log Daily Entry",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExperienceSelf(
                                      familyId: widget.familyId,
                                      currentLoggedInUserUid:
                                          widget.currentLoggedInUserUid,
                                    )),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  //survey inputs section
                  children: [
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.fromLTRB(width / 30, 30, width / 30, 15),
                      child: Text(
                        "Members",
                        style: TextStyle(
                            fontSize: height / 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.fromLTRB(width / 30, 5, width / 30, 15),
                        child: PendingResponses()),
                    for (var family in familyMemberList)
                      FamilyMemberWidget(
                        familyMember: family,
                        familyId: widget.familyId,
                        currentLoggedInUserUid: widget.currentLoggedInUserUid,
                      )
                  ],
                ),
    );
  }
}
