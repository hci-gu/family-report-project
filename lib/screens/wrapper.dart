import '../models/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './homescreen.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final familyMemberUser = Provider.of<FamilyMember>(context);
    print(familyMemberUser);
    //return home or  authenticate widget

    if (familyMemberUser == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
