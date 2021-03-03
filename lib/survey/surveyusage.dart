import 'package:flutter/material.dart';

class SurveyUsage extends StatelessWidget {
  final String familyMemberName;
  SurveyUsage(this.familyMemberName);

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
