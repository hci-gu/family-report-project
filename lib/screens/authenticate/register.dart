import 'package:flutter/material.dart';
import './../regulargreenbutton.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            "Sign up with Family ID",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Container(
          margin:
              EdgeInsets.only(left: width / 30, right: width / 30, bottom: 30),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RegularGreenButton(
                      "Sign up",
                      () async {
                        print(email);
                        print(password);
                        // dynamic result = await _auth.signIn();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
