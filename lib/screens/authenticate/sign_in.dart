import 'package:flutter/material.dart';
import './../regulargreenbutton.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';
import 'package:flutter/services.dart';

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
  String familyId = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    return (loading)
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
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
            body: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: Container(
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
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                              textCapitalization: TextCapitalization.none,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    new RegExp(" "))
                              ],
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
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              textCapitalization: TextCapitalization.none,
                              decoration: InputDecoration(
                                hintText: 'Family ID',
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'enter a family ID' : null,
                              onChanged: (val) {
                                setState(() {
                                  familyId = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Password',
                              ),
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
                                          email, password, familyId);
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
            ),
          );
  }
}
