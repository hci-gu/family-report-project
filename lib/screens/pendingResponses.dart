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
    var familyMemberList = Provider.of<List<FamilyMember>>(context) ?? [];
    int pendingResponses = 0;
    print("widget rebuilt");
    for (var family in familyMemberList) {
      if (family.isSurveyFilled == false) {
        print(family.isSurveyFilled);
        pendingResponses = pendingResponses + 1;
      }
    }

    return Text(
      "$pendingResponses Pending Responses",
      overflow: TextOverflow.fade,
      maxLines: 1,
      style: TextStyle(
        fontSize: height / 50,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
