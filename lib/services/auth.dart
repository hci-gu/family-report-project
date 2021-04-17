import 'package:family_report_project/models/model.dart';
import 'package:family_report_project/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  //sign in anon (for the sake of it)
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _familyMemberFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //sign in with email and password

  //register with email and password\
  Future registerWithEmailAndPassword(
      String name, String email, String password, String familyId) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

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
