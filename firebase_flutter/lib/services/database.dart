import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/data.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference dataCollection =
      Firestore.instance.collection('first');

  Future updateUserData(String position, String name, int number) async {
    return await dataCollection
        .document(uid)
        .setData(({'position': position, 'name': name, 'number': number}));
  }

  // Data List from Snapshot
  List<Data> _dataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Data(
        name: doc.data['name'] ?? '',
        position: doc.data['position'] ?? '',
        number: doc.data['number'] ?? 0,
      );
    }).toList();
  }

  // Get data Stream
  Stream<List<Data>> get data {
    return dataCollection.snapshots().map(_dataListFromSnapshot);
  }
}
