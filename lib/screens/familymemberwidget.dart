import 'package:flutter/material.dart';
import '../models/model.dart';
import 'survey/survey.dart';

class FamilyMemberWidget extends StatelessWidget {
  final FamilyMember familyMember;
  final String currentLoggedInUserUid;
  final String familyId;
  final FamilyMember currentLoggedFamilyMember;

  FamilyMemberWidget(
      {this.familyMember,
      this.familyId,
      this.currentLoggedInUserUid,
      this.currentLoggedFamilyMember});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: width / 30, right: width / 30, bottom: 15),
      child: ElevatedButton(
        child: Container(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    familyMember.name[0],
                    style: TextStyle(fontSize: height / 35),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: width / 2.2,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      familyMember.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: height / 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: Text(
                      familyMember.relation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: height / 45,
                      ),
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              Spacer(),
              Container(
                child: (currentLoggedFamilyMember
                            .isSurveyFilled[familyMember.id] ==
                        false)
                    ? Row(
                        children: [
                          Text(
                            "Survey",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: height / 50,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Container(
                            child: Icon(
                              Icons.east,
                              color: Theme.of(context).primaryColor,
                              size: height / 40,
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            "Done",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: height / 50,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Container(
                            child: Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                              size: height / 40,
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          )
                        ],
                      ),
              )
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(12.0),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SurveyForm(familyMember, familyId, currentLoggedInUserUid)),
          );
        },
      ),
    );
  }
}
