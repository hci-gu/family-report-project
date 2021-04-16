import 'package:flutter/material.dart';
import '../models/model.dart';

class Settings extends StatefulWidget {
  // final FamilyMember familyMember;
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Settings",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.face),
              title: Text(settingsList[0]),
              // onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => EditFamily(familyMemberList[index])));
              // },
            ),
            // body: Container(
            //   margin: EdgeInsets.all(width / 20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       for (var i = 0; i < settingsList.length; i++)
            //         Padding(
            //           padding: EdgeInsets.only(bottom: 15),
            //           child: TextButton.icon(
            //             onPressed: () {},
            //             icon: Icon(
            //               iconsList[i],
            //               color: settingsColors[i],
            //               size: height / 25,
            //             ),
            //             label: Text(
            //               settingsList[i],
            //               style: TextStyle(
            //                 fontSize: height / 30,
            //                 color: settingsColors[i],
            //               ),
            //             ),
            //           ),
            //         ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
