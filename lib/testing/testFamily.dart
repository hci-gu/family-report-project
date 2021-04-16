import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/model.dart';
import 'editFamily.dart';

class TestFamily extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final familyMemberList = Provider.of<List<FamilyMember>>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditFamily()));
              },
            )
          ],
        ),
        body: (familyMemberList != null)
            ? ListView.builder(
                itemCount: familyMemberList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(familyMemberList[index].name),
                    subtitle: Text(familyMemberList[index].relation),
                    trailing: Text(familyMemberList[index].age),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EditFamily(familyMemberList[index])));
                    },
                  );
                })
            : Center(child: CircularProgressIndicator()));
  }
}
