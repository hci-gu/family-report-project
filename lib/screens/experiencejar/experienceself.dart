import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import './experiencefamily.dart';

class ExperienceSelf extends StatefulWidget {
  final String familyId;
  final String currentLoggedInUserUid;
  final experienceLogSchedule;
  ExperienceSelf(
      {Key key,
      this.familyId,
      this.currentLoggedInUserUid,
      this.experienceLogSchedule})
      : super(key: key);

  @override
  _ExperienceSelfState createState() => _ExperienceSelfState();
}

class _ExperienceSelfState extends State<ExperienceSelf> {
  String selfInput = "";

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final node = FocusScope.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        title: Text("Experience Jar - Self",
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
                  "1. Tell us about at least one significant observation you made about your own smartphone usage",
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your response to the question',
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter your response.' : null,
                  onChanged: (val) {
                    setState(() {
                      selfInput = val;
                    });
                  },
                ),
                RegularGreenButton(
                  "Continue",
                  () {
                    DateTime now = new DateTime.now();
                    DateTime currentDate =
                        new DateTime(now.year, now.month, now.day);
                    print(
                        "${currentDate.day}-${currentDate.month}-${currentDate.year}");
                    var tempLogging = {
                      "${currentDate.day}-${currentDate.month}-${currentDate.year}":
                          {
                        "Experience Logging Self": "",
                        "Experience Logging Family": ""
                      }
                    };
                    tempLogging[
                            "${currentDate.day}-${currentDate.month}-${currentDate.year}"]
                        ["Experience Logging Self"] = selfInput;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExperienceFamily(
                          familyId: widget.familyId,
                          currentLoggedInUserUid: widget.currentLoggedInUserUid,
                          tempLogging: tempLogging,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
