import 'package:firebase_flutter/models/data.dart';
import 'package:flutter/material.dart';

class DataTile extends StatelessWidget {
  final Data data;
  DataTile({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue[data.number],
          ),
          title: Text(data.name),
          subtitle: Text('Is a ${data.position}'),
        ),
      ),
    );
  }
}
