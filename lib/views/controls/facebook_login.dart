import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FacebookButton extends StatelessWidget {
  FacebookButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: RaisedButton(
          color: new Color(0xFF3B5998),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'f',
                style: TextStyle(
                    height: 1.4,
                    fontFamily: "Klavika",
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.white),
              ),
              Text(
                'Sign in with facebook',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          )),
      width: 250.0,
    );
  }
}
