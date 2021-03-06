import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/models/user.dart';
import 'package:firebase_flutter/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create User Object based on Firebase User
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth Change User Stream
  Stream<User> get user {
    // Return a mapped user based on my USER Model whenever state changes
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // Return an instance of User class based on Firebase obj
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with Email & Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // Create a new unique document for user based on their UID
      await DatabaseService(uid: user.uid).updateUserData('', 'Member', 0);

      // Return an instance of User class based on Firebase obj
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
