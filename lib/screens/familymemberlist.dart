import './../models/model.dart';
import 'familymemberwidget.dart';
import './regulargreenbutton.dart';
import './experiencejar/experienceself.dart';
import './screentimeuploadandroid.dart';
import './pendingResponses.dart';
import './../services/database.dart';
import './screentimeupload.dart';
import './../helpers/notificationhelpers.dart';
import '../main.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class FamilyMemberList extends StatefulWidget {
  final String familyId;
  final String currentLoggedInUserUid;

  FamilyMemberList({Key key, this.familyId, this.currentLoggedInUserUid})
      : super(key: key);

  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  bool isAllSurveysFilled;

  var experienceLogSchedule = Map<String, bool>();
  int experienceDaysLogged;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final familyMemberList = Provider.of<List<FamilyMember>>(context) ?? [];
    FamilyMember currentLoggedFamilyMember;

    //change isAllSurveyFilled to false if even one of the surveys are not filled
    for (var familyMember in familyMemberList) {
      if (familyMember.id == widget.currentLoggedInUserUid) {
        experienceDaysLogged = familyMember.noOfXPDaysLogged;
        currentLoggedFamilyMember = familyMember;
        print(currentLoggedFamilyMember.id);

        isAllSurveysFilled = familyMember.isSurveyFilled.values.every(
            (element) =>
                element == true); //update isAllSurveysFilled from firebase data
        if (isAllSurveysFilled == true &&
            currentLoggedFamilyMember.experienceLogSchedule.isEmpty) {
          //initialise logging schedule once all surveys are filled
          for (int k = 0; k < 14; k++) {
            experienceLogSchedule[
                currentDate.add(Duration(days: k)).toString()] = false;
          }
          DatabaseService(widget.familyId, uid: widget.currentLoggedInUserUid)
              .updateExperienceLogSchedule(experienceLogSchedule);
        }
        experienceLogSchedule = currentLoggedFamilyMember
            .experienceLogSchedule; //update the log schedule from firebase
      }
    }

    if (experienceDaysLogged == 14) {
      flutterLocalNotificationsPlugin.cancelAll();
    }
    print(familyMemberList.length);
    return Container(
      child: (familyMemberList.length == null)
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
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextButton.icon(
                          style: ButtonStyle(alignment: Alignment.centerLeft),
                          onPressed: () {
                            DatePicker.showTime12hPicker(context,
                                showTitleActions: true, onConfirm: (date) {
                              print('confirm $date');
                              scheduleDailyNotification(
                                  flutterLocalNotificationsPlugin,
                                  '0',
                                  "Log your daily Obervations!",
                                  date);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          icon: Icon(
                            Icons.alarm,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: Text(
                            "Set Daily Log Reminder",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: height / 37),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 10),
                        child: TextButton.icon(
                          style: ButtonStyle(alignment: Alignment.centerLeft),
                          onPressed: () {
                            Navigator.of(context).push(
                              (Platform.isIOS == true)
                                  ? MaterialPageRoute(
                                      builder: (context) => ScreenTimeUpload(),
                                    )
                                  : MaterialPageRoute(
                                      builder: (context) =>
                                          ScreenTimeUploadAndroid(),
                                    ),
                            );
                          },
                          icon: Icon(
                            Icons.upload_file,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: Text(
                            "Upload screentime data",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: height / 37),
                          ),
                        ),
                      ),
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
                              : "All days Logged, nice!",
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
                            ? ((experienceLogSchedule[currentDate.toString()] ==
                                    false)
                                ? RegularGreenButton(
                                    "Log Daily Entry",
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ExperienceSelf(
                                            familyId: widget.familyId,
                                            experienceLogSchedule:
                                                experienceLogSchedule,
                                            currentLoggedInUserUid:
                                                widget.currentLoggedInUserUid,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Text("Today's log filled, Nice!"))
                            : Text(
                                "You're all set!",
                                style: TextStyle(
                                    fontSize: height / 30,
                                    color: Theme.of(context).primaryColor),
                              ),
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
                        "Family Members",
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
                    for (var familyMember in familyMemberList)
                      FamilyMemberWidget(
                        familyMember: familyMember,
                        familyId: widget.familyId,
                        currentLoggedInUserUid: widget.currentLoggedInUserUid,
                        currentLoggedFamilyMember: currentLoggedFamilyMember,
                      )
                  ],
                ),
    );
  }
}
