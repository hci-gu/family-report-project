import 'package:family_report_project/services/database.dart';
import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import '.././homescreen.dart';

class ExperienceFamily extends StatefulWidget {
  final String familyId;
  final String currentLoggedInUserUid;
  final Map<String, Map<String, String>> tempLogging;
  final Map<String, bool> experienceLogSchedule;

  ExperienceFamily(
      {Key key,
      this.familyId,
      this.currentLoggedInUserUid,
      this.tempLogging,
      this.experienceLogSchedule})
      : super(key: key);

  @override
  _ExperienceFamilyState createState() => _ExperienceFamilyState();
}

class _ExperienceFamilyState extends State<ExperienceFamily> {
  String familyInput = "";
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final node = FocusScope.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        title: Text("Experience Jar - Family",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottom),
          child: Container(
            margin: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
            child: Column(
              children: [
                Text(
                  "1. Tell us about at least one significant or interesting observation you made about your family's smartphone usage",
                  style: TextStyle(
                    fontSize: height / 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => node.nextFocus(),
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your response to the question',
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your response.' : null,
                  onChanged: (val) {
                    setState(() {
                      familyInput = val;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RegularGreenButton("Finish Daily Log", () async {
                  DateTime now = DateTime.now();
                  DateTime currentDate = DateTime(now.year, now.month, now.day);
                  widget.tempLogging[
                          "${currentDate.day}-${currentDate.month}-${currentDate.year}"]
                      ["Experience Logging Family"] = familyInput;

                  widget.experienceLogSchedule[currentDate.toString()] = true;

                  //update logging responses, logging schedule and no of responses on firebase
                  await DatabaseService(widget.familyId,
                          uid: widget.currentLoggedInUserUid)
                      .updateFamilyMemberXPLoggingResponses(
                          widget.tempLogging, widget.experienceLogSchedule);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                familyId: widget.familyId,
                                loggedInUserUid: widget.currentLoggedInUserUid,
                              )),
                      (Route<dynamic> route) => false);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
