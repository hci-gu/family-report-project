import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import './experiencefamily.dart';

class ExperienceSelf extends StatefulWidget {
  final String familyId;
  final String currentLoggedInUserUid;
  ExperienceSelf({Key key, this.familyId, this.currentLoggedInUserUid})
      : super(key: key);

  @override
  _ExperienceSelfState createState() => _ExperienceSelfState();
}

class _ExperienceSelfState extends State<ExperienceSelf> {
  final _formKey = GlobalKey<FormState>();
  String selfInput = "";

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final node = FocusScope.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Experience Jar - Self"),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottom),
            child: Column(
              children: [
                Container(
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
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.fromLTRB(width / 30, 10, width / 30, 30),
                  child: RegularGreenButton("Continue", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExperienceFamily(
                                familyId: widget.familyId,
                                currentLoggedInUserUid:
                                    widget.currentLoggedInUserUid,
                              )),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
