import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/data.dart';
import 'package:firebase_flutter/models/user.dart';

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

  //UserData From Snapshot
  UserData _userDataListFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      position: snapshot.data['position'],
      number: snapshot.data['number'],
    );
  }

  // Get data Stream
  Stream<List<Data>> get data {
    return dataCollection.snapshots().map(_dataListFromSnapshot);
  }

  // Get User Doc Stream
  Stream<UserData> get userData {
    return dataCollection.document(uid).snapshots().map(_userDataListFromSnapshot);
  }
}
