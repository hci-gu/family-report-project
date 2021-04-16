import 'package:flutter/material.dart';
import '../regulargreenbutton.dart';
import './register.dart';
import './sign_in.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Scaffold(
        body: Container(
          margin:
              EdgeInsets.only(left: width / 30, right: width / 30, bottom: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  "Screen Time Family Study",
                  style: TextStyle(
                      fontSize: height / 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Welcome! This app is to facilitate the research study. Here, you can provide your estimates of screen time data for all family members. The app will also collect screen time data from the smartphone for comparisons.",
                  style: TextStyle(fontSize: height / 40),
                ),
              ),
              Spacer(),
              RegularGreenButton(
                "Sign in",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
              ),
              RegularGreenButton(
                "Sign up",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
