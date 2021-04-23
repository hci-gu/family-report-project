import 'package:flutter/material.dart';
import './../models/model.dart';
import 'package:provider/provider.dart';

class PendingResponses extends StatefulWidget {
  final String currentLoggedInUserUid;
  PendingResponses({Key key, this.currentLoggedInUserUid}) : super(key: key);

  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<PendingResponses> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var familyMemberList = Provider.of<List<FamilyMember>>(context) ?? [];
    int pendingResponses = 0;

    //update pending responses counter
    for (var familyMember in familyMemberList) {
      if (familyMember.id == widget.currentLoggedInUserUid) {
        for (var key in familyMember.isSurveyFilled.keys) {
          if (familyMember.isSurveyFilled[key] == false) {
            pendingResponses = pendingResponses + 1;
          }
        }
      }
    }

    return (pendingResponses == 0)
        ? Container()
        : Text(
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
