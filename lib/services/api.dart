import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_report_project/models/model.dart';
import 'dart:async';

class Api {
  //DocumentReference is a document location in firebaseFirestore database, and is used to write, read, and listen to a that specific location.
  //CollectionReference is an object used for getting document reference, and querying documents.
  CollectionReference ref;
  final String path;

  //Creates an instance of the firestore database
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Api(this.path) {
    //firebase data is stored within documents, which are contained within collections. The collection method lets us reference a specific collection in firestore.
    ref = _db.collection(path);
  }

  //Future is used to return asynchronous objects.
  //querysnapshot contains results of a query. It may contain one or more documentSnapshots. Document Snapshot contains data read from a document in firestore.
  Future<void> saveFamilyMember(FamilyMember member) {
    return ref.doc(member.id).set(member.toJSON());
  }

  Stream<List<FamilyMember>> getFamilyMembersList() {
    return ref.snapshots().map((snapshot) => snapshot.docs
        .map((document) => FamilyMember.fromJSON(document.data()))
        .toList());
  }

  Future<void> removeFamilyMember(String familyMemberId) {
    return ref.doc(familyMemberId).delete();
  }
}
