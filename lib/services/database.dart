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

  Future createFamilyMemberDataWithName(
      String name, String age, String relation, String gender) async {
    await ref.get().then((snapshot) async {
      var idList = [];
      snapshot.docs.forEach((doc) => {idList.add(doc.data()['id'])});
      var temp = Map<String, bool>();
      for (var id in idList) {
        //setting the isSurveyFilled for uid by every other id to false
        ref.doc(id).set(
          {
            'isSurveyFilled': {
              uid: false,
            }
          },
          SetOptions(merge: true),
        );
        temp[id] = false; // setting isSurveyFilled for 'id' by 'uid' to false
      }
      temp[uid] = false; // setting isSurveyFilled for 'uid' by 'uid' to false

      return await ref.doc(uid).set({
        'name': name,
        'id': uid,
        'isSurveyFilled': temp,
        'relation': relation,
        'age': age,
        'gender': gender,
        'surveyQuestionResponses': new Map<String, Map<String, String>>(),
        'qualitativeStudyResponses': new Map<String, Map<String, String>>(),
        'totalScreenTime': new Map<String, double>(),
        'hourlyScreenTimeBreakdown': new Map<String, List<double>>(),
        'noOfXPDaysLogged': 0,
        'experienceLogSchedule': new Map<String, bool>(),
      });
    });
  }

  Future updateFamilyMemberSurveyResponses(
      Map<String, Map<String, String>> surveyResponses,
      String surveyFilledForId) async {
    return await ref.doc(uid).set(
      {
        'surveyQuestionResponses': surveyResponses,
        'isSurveyFilled': {surveyFilledForId: true}
      },
      SetOptions(merge: true),
    );
  }

  Future updateExperienceLogSchedule(Map<String, bool> logSchedule) async {
    return await ref.doc(uid).set(
      {
        'experienceLogSchedule': logSchedule,
      },
      SetOptions(merge: true),
    );
  }

  Future updateFamilyMemberXPLoggingResponses(
      Map<String, Map<String, String>> loggedResponses) async {
    ref.doc(uid).get().then((document) async {
      var temp;
      temp = document.get('noOfXPDaysLogged');
      return await ref.doc(uid).set({
        'qualitativeStudyResponses': loggedResponses,
        'noOfXPDaysLogged': temp + 1
      }, SetOptions(merge: true));
    });
  }

  Future updateFamilyMemberScreenTimeData(Map<String, double> totalScreenTime,
      Map<String, List<double>> screenTimeBreakdown) async {
    return await ref.doc(uid).set(
      {
        'totalScreenTime': totalScreenTime,
        'hourlyScreenTimeBreakdown': screenTimeBreakdown,
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
      noOfXPDaysLogged: snapshot.data()['noOfXPDaysLogged'],
      experienceLogSchedule: snapshot.data()['experienceLogSchedule'],
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
        noOfXPDaysLogged: doc.data()['noOfXPDaysLogged'],
        experienceLogSchedule:
            Map<String, bool>.from(doc.data()['experienceLogSchedule']),
      );
    }).toList();
  }
}
