import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  //stream provides a way to receive a sequence of events asynchronously
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).get();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.doc(id).update(data);
  }
}
