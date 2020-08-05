import 'package:firebase_flutter/constants/const.dart';
import 'package:firebase_flutter/constants/loading.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //Passing Through Function into Widget
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text Field State
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign In to App'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
            textColor: Colors.white,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                ),
                // Check if field is empty
                validator: (val) => val.isEmpty ? 'Enter An Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                ),
                obscureText: true,
                //Check password length
                validator: (val) =>
                    val.length < 6 ? 'Enter a 6+ char password' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // Validate form based on Current State
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Error';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// LoginAnon(auth: _auth),
class LoginAnon extends StatelessWidget {
  const LoginAnon({
    Key key,
    @required AuthService auth,
  })  : _auth = auth,
        super(key: key);

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
    );
  }
}
