import './familymemberlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/model.dart';
import '../services/database.dart';
import './screentimeupload.dart';
import './settings.dart';
import './usage.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  final String familyId;
  final String loggedInUserUid;
  HomeScreen({Key key, this.familyId, this.loggedInUserUid}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StreamProvider<List<FamilyMember>>.value(
      value: DatabaseService(widget.familyId).familyMemberList,
      initialData: null,
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(width / 30, 30, width / 30, 15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Hello, ${widget.familyId}!",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: height / 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 32.0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(
                      "You can report your estimates of smartphone usage for each family member from here and view comparisons at the end of the study.",
                      style: TextStyle(
                        fontSize: height / 35,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: TextButton.icon(
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UsageData(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Show usage data",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: height / 37),
                        ),
                      ),
                    ),
                    (Platform.isIOS == true)
                        ? Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10),
                            child: TextButton.icon(
                              style:
                                  ButtonStyle(alignment: Alignment.centerLeft),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ScreenTimeUpload(),
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
                          )
                        : Container(),
                  ],
                ),
              ),
              FamilyMemberList(
                familyId: widget.familyId,
                currentLoggedInUserUid: widget.loggedInUserUid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
