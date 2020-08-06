import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/data.dart';
import 'package:firebase_flutter/screens/home/dataList.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: Text('Bottom Sheet'),
          );
        },
      );
    }

    return StreamProvider<List<Data>>.value(
      value: DatabaseService().data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Flutter Firebase'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('logout'),
              textColor: Colors.white,
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('settings'),
              textColor: Colors.white,
            ),
          ],
        ),
        body: DataList(),
      ),
    );
  }
}
