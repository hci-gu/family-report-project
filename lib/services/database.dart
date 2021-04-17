import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_report_project/models/model.dart';

class DatabaseService {
  //collection reference
  CollectionReference ref;
  final String path;
  final String uid;

  //Creates an instance of the firestore database
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService(this.path, {this.uid}) {
    //firebase data is stored within documents, which are contained within collections. The collection method lets us reference a specific collection in firestore.
    ref = _db.collection(path);
  }

  Future createFamilyMemberDataWithName(String name) async {
    return await ref.doc(uid).set({'name': name, 'id': uid});
  }

  Stream<List<FamilyMember>> get familyMemberList {
    return ref.snapshots().map(_familyMemberListFromSnapshot);
  }

  List<FamilyMember> _familyMemberListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.data()['id']);
      // print(doc.data()['name']);
      return FamilyMember(
        id: doc.data()['id'],
        name: doc.data()['name'],
      );
    }).toList();
  }
}
