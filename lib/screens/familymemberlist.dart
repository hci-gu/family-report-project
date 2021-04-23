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
    bool isAllSurveysFilled = true; // set default  to true
    int experienceDaysLogged;

    //chnge isAllSurveyFilled to false if even one of the surveys are not filled
    for (var familyMember in familyMemberList) {
      if (familyMember.id == widget.currentLoggedInUserUid) {
        experienceDaysLogged = familyMember.noOfXPDaysLogged;
        for (var key in familyMember.isSurveyFilled.keys) {
          if (familyMember.isSurveyFilled[key] == false) {
            isAllSurveysFilled = false;
          }
        }
      }
    }

    return Container(
      child: familyMemberList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (isAllSurveysFilled == true)
              ? Container(
                  margin: EdgeInsets.fromLTRB(width / 30, 0, width / 30, 0),
                  child: Column(
                    //experience jar section
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Experience Logging",
                          style: TextStyle(
                              fontSize: height / 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "All Surveys Filled, Thank you! We will now proceed with the qualitative study, where you need to spend just 5 mins a day answering 2 questions, for two weeks.",
                          style: TextStyle(
                            fontSize: height / 40,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          (experienceDaysLogged != 14)
                              ? "$experienceDaysLogged days logged"
                              : "All days Logged!",
                          style: TextStyle(
                              fontSize: height / 50,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: LinearProgressIndicator(
                          minHeight: 8.0,
                          semanticsValue: (experienceDaysLogged).toString(),
                          backgroundColor: Theme.of(context).accentColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                          value: experienceDaysLogged.toDouble() / 14,
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 15),
                        child: (experienceDaysLogged != 14)
                            ? RegularGreenButton(
                                "Log Daily Entry",
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExperienceSelf(
                                        familyId: widget.familyId,
                                        currentLoggedInUserUid:
                                            widget.currentLoggedInUserUid,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                      ),
                    ],
                  ),
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
                      child: PendingResponses(
                        currentLoggedInUserUid: widget.currentLoggedInUserUid,
                      ),
                    ),
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
