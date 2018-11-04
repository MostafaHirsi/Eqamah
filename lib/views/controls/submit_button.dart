import 'dart:async';

import 'package:eqamah/views/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton(
      {Key key,
      @required this.formKey,
      @required this.buttonText,
      @required this.submitFunction})
      : super(key: key);

  GlobalKey<FormState> formKey;
  String buttonText;
  Future<Object> submitFunction;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(40.0),
      child: RaisedButton(
        color: new Color(0xFFf8653c),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          ),
        onPressed: () async {
          if (formKey.currentState.validate()) {
            await submitFunction;
          }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
        },
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
      width: 250.0,
    );
  }
}
