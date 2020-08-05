import 'package:cloud_firestore/cloud_firestore.dart';

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
}
