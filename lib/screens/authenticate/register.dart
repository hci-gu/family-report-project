import 'package:flutter/material.dart';
import './../regulargreenbutton.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String name = "";
  String email = "";
  String password = "";
  String familyId = "";
  String age = "";
  String gender = "Female";
  String relation = 'Mother';
  String error = "";

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    double width = MediaQuery.of(context).size.width;
    final node = FocusScope.of(context);
    return loading
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
                "Sign up with Family ID",
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
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter a name' : null,
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    new RegExp(" "))
                              ],
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => node.nextFocus(),
                              textCapitalization: TextCapitalization.none,
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
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
                                hintText: 'Password',
                              ),
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
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    new RegExp(" "))
                              ],
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
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    new RegExp(r"[0-9]"))
                              ],
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () => node.nextFocus(),
                              decoration: InputDecoration(
                                hintText: 'Age',
                              ),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your age' : null,
                              onChanged: (val) {
                                setState(() {
                                  age = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text("Enter your gender"),
                                value: gender,
                                onChanged: (String newValue) {
                                  setState(() {
                                    gender = newValue;
                                  });
                                },
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Other',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text("Enter your relation"),
                                value: relation,
                                onChanged: (String newValue) {
                                  setState(() {
                                    relation = newValue;
                                  });
                                },
                                items: <String>[
                                  'Father',
                                  'Mother',
                                  'Son',
                                  'Daughter',
                                  'Other',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RegularGreenButton(
                              "Sign up",
                              () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          name,
                                          email,
                                          password,
                                          familyId,
                                          age,
                                          relation,
                                          gender);
                                  Navigator.pop(context);
                                  if (result == null) {
                                    setState(() {
                                      error = "please give a valid email";
                                      loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
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
