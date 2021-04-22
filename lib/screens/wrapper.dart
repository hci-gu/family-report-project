import '../models/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './homescreen.dart';
import './../services/database.dart';
import 'authenticate/authenticate.dart';
import './../helpers/sharedpreferenceshelper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final familyMemberUser = Provider.of<FamilyMember>(context);

    if (familyMemberUser == null) {
      return Authenticate();
    } else {
      return FutureBuilder<String>(
        future: SharedPreferencesHelper.getFamilyCollectionName(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return FutureBuilder<String>(
                  future: SharedPreferencesHelper.getFamilyMemberUid(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot2) {
                    switch (snapshot2.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        if (snapshot2.hasError) {
                          return Text('Error: ${snapshot2.error}');
                        } else {
                          return StreamProvider<FamilyMember>.value(
                            value:
                                DatabaseService(snapshot.data).familyMemberData,
                            initialData: null,
                            child: HomeScreen(
                              familyId: snapshot.data,
                              loggedInUserUid: snapshot2.data,
                            ),
                          );
                        }
                    }
                  },
                );
              }
          }
        },
      );
    }
  }
}
