import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../StorageObjects/emailStorage.dart';

class Setup extends StatefulWidget {
  Setup({this.title});

  final String title;

  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  String email;

  String getEmail() {
    if (textController.text.toString() != "") {
      email = textController.text.toString();
    } else {
      email = "";
    }
    return email;
  }

  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: Text("Enter Your email below",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25)),
            padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 15.0),
          ),
      Container(
        child: TextField(
          controller: textController,
          autocorrect: true,
        ),
        padding: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 120.0),
      ),
      Container(
        alignment: Alignment.bottomRight,
        child: RaisedButton(
          onPressed: () {
            EmailStorage.email = getEmail();
            Navigator.pop(context);
          },
          child: new Text("Done"),
        ),
      )
    ]));
  }
}
