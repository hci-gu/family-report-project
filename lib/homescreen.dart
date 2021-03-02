import 'package:flutter/material.dart';
import './familymember.dart';
import './settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var noOfPendingResponses = 2;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var familyMemberNames = [
      "Shreyas Gupta",
      "Srinivas Kukkadapu",
      "Swaroopa Gupta",
      "Shreshta Gupta",
      "Shourya Gupta"
    ];
    return Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "Hello Gupta Family!",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: height / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
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
                                  builder: (context) => Settings()),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(
                      "You can report your estimates of smartphone usage for each family member from here and view comparisons at the end of the study. ",
                      style: TextStyle(fontSize: height / 35),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10),
                      child: TextButton.icon(
                        style: ButtonStyle(alignment: Alignment.centerLeft),
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          "Invite to Family",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: height / 37),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Members",
                      style: TextStyle(
                          fontSize: height / 25, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "($noOfPendingResponses Pending Responses)",
                        style: TextStyle(
                          fontSize: height / 60,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(width / 40, 0, 0, 15),
              ),
              for (var family in familyMemberNames) FamilyMember(family, 'Son')
            ],
          ),
        ),
      ),
    );
  }
}
