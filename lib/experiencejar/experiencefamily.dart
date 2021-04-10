import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import '.././homescreen.dart';

class ExperienceFamily extends StatefulWidget {
  ExperienceFamily({Key key}) : super(key: key);

  @override
  _ExperienceFamilyState createState() => _ExperienceFamilyState();
}

class _ExperienceFamilyState extends State<ExperienceFamily> {
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
            RegularGreenButton("Finish Daily Log", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            })
          ],
        ),
      ),
    );
  }
}
