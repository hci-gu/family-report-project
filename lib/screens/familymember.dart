import 'package:flutter/material.dart';
import 'survey/survey.dart';

class FamilyMemberWidget extends StatelessWidget {
  final String familyMemberName;
  final String familyMemberRelation;
  var isSurveyFilled = false;

  FamilyMemberWidget(this.familyMemberName, this.familyMemberRelation);

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
                  padding: EdgeInsets.all(10),
                  child: Text(
                    familyMemberName
                        .split(" ")
                        .reduce((curr, next) => curr[0] + next[0])
                        .toUpperCase(),
                    style: TextStyle(fontSize: height / 45),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: width / 2.3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                      child: Text(
                        familyMemberName,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.black, fontSize: height / 45),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: Text(
                      familyMemberRelation,
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
                child: (isSurveyFilled == false)
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
                    : Text(
                        "Done",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: height / 50,
                        ),
                        textAlign: TextAlign.right,
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
                builder: (context) => SurveyForm(familyMemberName)),
          );
        },
      ),
    );
  }
}