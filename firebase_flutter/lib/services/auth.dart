import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create User Object based on Firebase User
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }


  // Sign In Anon
  Future signInAnon() async {
    try {
      //Attempt to sign in Anon and store result in user var
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      
      // Return an instance of User class based on Firebase obj
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // Sign In with Email & Password



  // Register with Email & Password



  // Sign Out


}
