import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign In to App'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: RaisedButton(
          child: Text('Sign In Anon'),
          onPressed: () async {
            // Dynamic cause Result can be multiple types
            dynamic result = await _auth.signInAnon();

            // Check if result returns an error or not
            if (result == null) {
              print('Error Signing In');
            } else {
              // Display User ID in Console
              print('Signed In');
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}
