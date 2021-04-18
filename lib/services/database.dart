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
    return await ref.doc(uid).set({
      'name': name,
      'id': uid,
      'isSurveyFilled': false,
      'relation': '',
      'age': '',
      'gender': '',
      'surveyQuestionResponses': new Map(),
      'qualitativeStudyResponses': new Map(),
      'totalScreenTime': 0.0,
      'hourlyScreenTimeBreakdown': [],
    });
  }

  Stream<List<FamilyMember>> get familyMemberList {
    return ref.snapshots().map(_familyMemberListFromSnapshot);
  }

  // Stream<FamilyMember> familyMember(String id) {
  //   return ref.doc(id);
  // }

  List<FamilyMember> _familyMemberListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FamilyMember(
        id: doc.data()['id'],
        name: doc.data()['name'],
        isSurveyFilled: doc.data()['isSurveyFilled'],
        totalScreenTime: doc.data()['totalScreenTime'],
        gender: doc.data()['gender'],
        age: doc.data()['age'],
        relation: doc.data()['relation'],
        surveyQuestionResponses: doc.data()['surveyQuestionResponses'],
        qualitativeStudyResponses: doc.data()['qualitativeStudyResponses'],
        hourlyScreenTimeBreakdown: doc.data()['hourlyScreenTimeBreakdown'],
      );
    }).toList();
  }
}
