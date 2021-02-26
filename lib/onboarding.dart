import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'regulargreenbutton.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "Placeholder Title",
                  style: TextStyle(
                      fontSize: height / 20, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              RegularGreenButton("Continue with Invite Link", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }),
              RegularGreenButton("Create Family ID", () {}),
            ],
          ),
        ),
      ),
    );
  }
}
