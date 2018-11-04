// Create a Form Widget
import 'dart:async';

import 'package:eqamah/views/controls/facebook_login.dart';
import 'package:eqamah/views/controls/submit_button.dart';
import 'package:eqamah/views/controls/textfield.dart';
import 'package:eqamah/views/controls/twitter_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  final String _userNameHint = 'Username';
  final String _passwordHint = 'Password';
  Future<bool> loginResult;

  TextEditingController passwordController, usernameController;

  void initState() {
    super.initState();
    passwordController = new TextEditingController();
    usernameController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    // borderRadius: new BorderRadius.all(const Radius.circular(8.0))

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: new Alignment(
                  0.0, 0.5), // 10% of the width, so there are ten blinds.
              colors: [const Color(0x55FFFFFF), const Color(0x55fd5e53)],
            ),
            image: new DecorationImage(
                image: new AssetImage(
                  'graphics/sun_island.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Color(0x55000000), BlendMode.luminosity)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "إقامة‎",
                  style: TextStyle(
                      fontSize: 90.0,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
                new StandardTextField(
                  userNameHint: _userNameHint,
                  icon:
                      Icon(Icons.supervised_user_circle, color: Colors.white70),
                  controller: usernameController,
                  errorText: "Please enter a username",
                  obscureText: false,
                ),
                new StandardTextField(
                  userNameHint: _passwordHint,
                  icon: Icon(Icons.verified_user, color: Colors.white70),
                  controller: passwordController,
                  errorText: "Please enter a password",
                  obscureText: true,
                ),
                SubmitButton(
                    buttonText: "Submit",
                    formKey: _formKey,
                    submitFunction: null),
                FacebookButton(),
                TwitterButton()
              ],
            ),
          ),
          padding: EdgeInsets.all(25.0),
        ),
      ],
    ));
  }
}
