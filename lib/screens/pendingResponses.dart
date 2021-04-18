import 'package:flutter/material.dart';
import './../models/model.dart';
import 'package:provider/provider.dart';

class PendingResponses extends StatefulWidget {
  PendingResponses({Key key}) : super(key: key);

  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<PendingResponses> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final familyMemberList = Provider.of<List<FamilyMember>>(context);
    int pendingResponses = 0;
    for (var family in familyMemberList) {
      if (family.isSurveyFilled == false) {
        pendingResponses = pendingResponses + 1;
      }
    }
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        "($pendingResponses Pending Responses)",
        style: TextStyle(
          fontSize: height / 60,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
