import 'package:firebase_flutter/constants/const.dart';
import 'package:firebase_flutter/constants/loading.dart';
import 'package:firebase_flutter/models/user.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> positions = ['Full-Time', 'Part-Time', 'Intern'];

  // Form Values
  String _currentName;
  String _currentPosition;
  int _currentNumber;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your Settings:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please Enter a Name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20),
                // Dropdown
                DropdownButtonFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: '-- Please Select --'),
                  value: _currentPosition,
                  items: positions.map((position) {
                    return DropdownMenuItem(
                      value: position,
                      child: Text('$position position'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentPosition = val),
                ),
                // Slider
                Slider(
                  value: (_currentNumber ?? userData.number).toDouble(),
                  activeColor: Colors.blue[_currentNumber ?? 100],
                  inactiveColor: Colors.blue[_currentNumber ?? 100],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentNumber = val.round()),
                ),
                // Submit
                RaisedButton(
                  color: Colors.blue[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentPosition ?? userData.position,
                          _currentName ?? userData.name,
                          _currentNumber ?? userData.number);
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
