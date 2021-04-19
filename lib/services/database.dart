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
      'surveyQuestionResponses': new Map<String, Map<String, String>>(),
      'qualitativeStudyResponses': new Map<String, Map<String, String>>(),
      'totalScreenTime': 0.0,
      'hourlyScreenTimeBreakdown': [],
    });
  }

  Future updateFamilyMemberSurveyResponses(
      Map<String, Map<String, String>> surveyResponses) async {
    return await ref.doc(uid).set(
      {
        'surveyQuestionResponses': surveyResponses,
        'isSurveyFilled': true,
      },
      SetOptions(merge: true),
    );
  }

  //creates a stream of updates from firestore for all the family members as a list
  Stream<List<FamilyMember>> get familyMemberList {
    return ref.snapshots().map(_familyMemberListFromSnapshot);
  }

  //creates a stream of updates from firestore for the particular family member user based on uid
  Stream<FamilyMember> get familyMemberData {
    return ref.doc(uid).snapshots().map(_familyMemberFromSnapshot);
  }

  FamilyMember _familyMemberFromSnapshot(DocumentSnapshot snapshot) {
    return FamilyMember(
      id: snapshot.data()['id'],
      name: snapshot.data()['name'],
      isSurveyFilled: snapshot.data()['isSurveyFilled'],
      totalScreenTime: snapshot.data()['totalScreenTime'],
      gender: snapshot.data()['gender'],
      age: snapshot.data()['age'],
      relation: snapshot.data()['relation'],
      surveyQuestionResponses: snapshot.data()['surveyQuestionResponses'],
      qualitativeStudyResponses: snapshot.data()['qualitativeStudyResponses'],
      hourlyScreenTimeBreakdown: snapshot.data()['hourlyScreenTimeBreakdown'],
    );
  }

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
