import 'package:flutter/material.dart';
import './../models/model.dart';
import 'package:provider/provider.dart';
import './familymember.dart';

class FamilyMemberList extends StatefulWidget {
  final String familyId;
  final String currentLoggedInUserUid;
  FamilyMemberList({Key key, this.familyId, this.currentLoggedInUserUid})
      : super(key: key);

  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  @override
  Widget build(BuildContext context) {
    final familyMemberList = Provider.of<List<FamilyMember>>(context) ?? [];
    return Container(
      child: familyMemberList.isEmpty
          ? CircularProgressIndicator()
          : Column(
              children: [
                for (var family in familyMemberList)
                  if (family.isSurveyFilled == false)
                    FamilyMemberWidget(
                      familyMember: family,
                      familyId: widget.familyId,
                      currentLoggedInUserUid: widget.currentLoggedInUserUid,
                    )
              ],
            ),
    );
  }
}
