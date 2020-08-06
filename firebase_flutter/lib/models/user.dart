// Data model consisting of key parts that user posseses
class User {
  final String uid;

  // User data only consists of ID
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String position;
  final int number;

  UserData({this.uid, this.name, this.number, this.position});
}
