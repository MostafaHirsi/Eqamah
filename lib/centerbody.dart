import 'dart:async';

import 'package:eqamah/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CenterBody extends StatelessWidget {
  CenterBody({
    Key key,
    @required int counter,
  })  : _counter = counter,
        super(key: key);

  final int _counter;
  
  @override
  Widget build(BuildContext context) {
    
    TextEditingController cntrlr = TextEditingController();
    TextEditingController cntrlrPw = TextEditingController();
    return new Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: new Column(
        // Column is also layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug paint" (press "p" in the console where you ran
        // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
        // window in IntelliJ) to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new UserTextField(loginDialog: "Username", cntrlr: cntrlr),
          new UserTextField(loginDialog: "Password", cntrlr: cntrlrPw),
          new SubmitButton(cntrlr: cntrlr, cntrlrPw: cntrlrPw)
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key, @required this.cntrlr, @required this.cntrlrPw,
  }) : super(key: key);
  
  final TextEditingController cntrlr;
  final TextEditingController cntrlrPw;
  
  @override
  Widget build(BuildContext context) {
    cntrlr.addListener((){


    });
    return Container(
      child: RaisedButton(
        onPressed: () async {
          bool loggedIn = await SendLogin(cntrlr.text, cntrlrPw.text);
        },

        child: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.green,
      ),
    );
  }
}

class UserTextField extends StatelessWidget {
  const UserTextField({
    Key key,
    @required this.loginDialog, @required this.cntrlr,
  }) : super(key: key);

  final String loginDialog;
  final TextEditingController cntrlr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0, 
      child: new TextField(
       
        controller: cntrlr,
        decoration: InputDecoration(
            hintText: loginDialog, hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
