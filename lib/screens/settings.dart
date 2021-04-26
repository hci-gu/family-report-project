import 'package:flutter/material.dart';
import '../services/auth.dart';

class SettingsPage extends StatefulWidget {
  // final FamilyMember familyMember;
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
            "SettingsPage",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.face),
              title: Text("Sign Out"),
              onTap: () async {
                await _auth.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
