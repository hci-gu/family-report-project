import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import './experiencefamily.dart';

class ExperienceSelf extends StatefulWidget {
  ExperienceSelf({Key key}) : super(key: key);

  @override
  _ExperienceSelfState createState() => _ExperienceSelfState();
}

class _ExperienceSelfState extends State<ExperienceSelf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Experience Jar"),
        ),
        body: Column(
          children: [
            Text(""),
            Spacer(),
            RegularGreenButton("Continue", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExperienceFamily()),
              );
            })
          ],
        ),
      ),
    );
  }
}
