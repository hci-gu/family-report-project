import 'package:family_report_project/models/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create familyMember object from firebase User
  FamilyMember _familyMemberFromFirebaseUser(User user) {
    // return (user != null) ? FamilyMember(user.uid, user, relation, age, gender): null;
  }

  //stream to listen to auth state changes
  Stream<FamilyMember> get familyMemberUser {
    _auth
        .authStateChanges()
        .map((User user) => _familyMemberFromFirebaseUser(user));
  }

  //sign in anon (for the sake of it)
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _familyMemberFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }
  //sign in with email and password

  //register with email and password

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
