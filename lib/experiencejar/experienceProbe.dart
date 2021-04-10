import 'package:flutter/material.dart';
import '.././regulargreenbutton.dart';
import './experienceself.dart';

class ExperienceProbeInputs extends StatefulWidget {
  ExperienceProbeInputs({Key key}) : super(key: key);

  @override
  _ExperienceProbeInputsState createState() => _ExperienceProbeInputsState();
}

class _ExperienceProbeInputsState extends State<ExperienceProbeInputs> {
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
                MaterialPageRoute(builder: (context) => ExperienceSelf()),
              );
            })
          ],
        ),
      ),
    );
  }
}
