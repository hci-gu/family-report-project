import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var settingsList = ["Edit Profile", "Feedback", "About", "Delete Account"];
    var iconsList = [
      Icons.face,
      Icons.chat,
      Icons.lightbulb,
      Icons.delete_forever
    ];
    var settingsColors = [Colors.black, Colors.black, Colors.black, Colors.red];
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Container(
          margin: EdgeInsets.all(width / 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < settingsList.length; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      iconsList[i],
                      color: settingsColors[i],
                      size: height / 25,
                    ),
                    label: Text(
                      settingsList[i],
                      style: TextStyle(
                        fontSize: height / 30,
                        color: settingsColors[i],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
