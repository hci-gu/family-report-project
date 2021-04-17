import 'package:flutter/material.dart';
import './../models/model.dart';
import 'package:provider/provider.dart';
import './familymember.dart';

class FamilyMemberList extends StatefulWidget {
  FamilyMemberList({Key key}) : super(key: key);

  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  @override
  Widget build(BuildContext context) {
    final familyMemberList = Provider.of<List<FamilyMember>>(context);
    print(familyMemberList[0].name);
    return Container(
      child: Column(
        children: [
          for (var family in familyMemberList)
            FamilyMemberWidget(familyMember: family)
        ],
      ),
    );
  }
}
