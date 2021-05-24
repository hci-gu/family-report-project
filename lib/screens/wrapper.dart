import '../models/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './homescreen.dart';
import 'authenticate/authenticate.dart';
import './../helpers/sharedpreferenceshelper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final familyMemberUser = Provider.of<FamilyMember>(context);

    if (familyMemberUser == null) {
      print("tried authentication screen");
      return Authenticate();
    } else {
      print("home screen");
      return Scaffold(
        body: FutureBuilder<String>(
          initialData: "yes",
          future: SharedPreferencesHelper.getFamilyCollectionName(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  print("${snapshot.data}");
                  return const CircularProgressIndicator();
                } else {
                  return FutureBuilder<String>(
                    future: SharedPreferencesHelper.getFamilyMemberUid(),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot2) {
                      switch (snapshot2.connectionState) {
                        case ConnectionState.waiting:
                          return const CircularProgressIndicator();
                        default:
                          if (snapshot2.hasError) {
                            return Text('Error: ${snapshot2.error}');
                          } else if (snapshot2.data == null) {
                            return const CircularProgressIndicator();
                          } else {
                            print(snapshot.data);
                            return HomeScreen(
                              familyId: snapshot.data,
                              loggedInUserUid: snapshot2.data,
                            );
                          }
                      }
                    },
                  );
                }
            }
          },
        ),
      );
      ;
    }
  }
}
