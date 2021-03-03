import 'package:flutter/material.dart';

class SurveyWL extends StatelessWidget {
  final String familyMemberName;
  SurveyWL(this.familyMemberName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text(
                "For how many hours does $familyMemberName use his/her smartphone in a day?"),
          ],
        ),
      ),
    );
  }
}
