import 'package:family_report_project/models/model.dart';
import 'package:family_report_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/sharedpreferenceshelper.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create familyMember object from firebase User
  FamilyMember _familyMemberFromFirebaseUser(User user) {
    return (user != null) ? FamilyMember(id: user.uid) : null;
  }

  //stream to listen to auth state changes
  Stream<FamilyMember> get familyMemberUser {
    return _auth
        .authStateChanges()
        .map((User user) => _familyMemberFromFirebaseUser(user));
  }

  //register with email and password\
  Future registerWithEmailAndPassword(
      String name, String email, String password, String familyId) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // set familyID and FamilyMember UID to shared preferences for quick reference without using provider
      Future<bool> test =
          SharedPreferencesHelper.setFamilyCollectionName(familyId);
      test.then((value) => (value)
          ? print("familyID saved in shared Preferences")
          : print("error in saving familyID to shared Preferences"));
      Future<bool> uidTest =
          SharedPreferencesHelper.setFamilyMemberUid(result.user.uid);
      uidTest.then((value) => (value)
          ? print("FamilyMember UID saved in shared Preferences")
          : print("error in saving FamilyMember UID to shared Preferences"));

      await DatabaseService(familyId, uid: result.user.uid)
          .createFamilyMemberDataWithName(name);
      return _familyMemberFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _familyMemberFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
