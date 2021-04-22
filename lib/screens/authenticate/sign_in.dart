import 'package:flutter/material.dart';
import './../regulargreenbutton.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return (loading)
        ? Loading()
        : Container(
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Theme.of(context).primaryColor,
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColor,
                title: Text(
                  "Sign in with Family ID",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              body: Container(
                margin: EdgeInsets.only(
                    left: width / 30, right: width / 30, bottom: 30),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.none,
                            validator: (val) =>
                                val.isEmpty ? 'enter an email' : null,
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
                            textCapitalization: TextCapitalization.none,
                            validator: (val) => val.length < 6
                                ? 'enter a password more than 6 characters'
                                : null,
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
                            "Sign in",
                            () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                Navigator.pop(context);
                                if (result == null) {
                                  setState(() {
                                    error = "couldn't sign in";
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(fontSize: 14),
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
