import 'package:firebase_flutter/constants/const.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> positions = ['Full-Time', 'Part-Time', 'Intern'];

  String _currentName;
  String _currentPosition;
  int _currentNumber;

  @override
  Widget build(BuildContext context) {
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
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please Enter a Name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 20),
          // Dropdown
          DropdownButtonFormField(
            decoration: InputDecoration(hintText: '-- Please Select --'),
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

          // Submit
          RaisedButton(
            color: Colors.blue[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentPosition);
              print(_currentNumber);
            },
          )
        ],
      ),
    );
  }
}
