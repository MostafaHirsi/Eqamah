import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TwitterButton extends StatelessWidget {
  TwitterButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: RaisedButton(
          color: new Color(0xFF0084FF),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        alignment: Alignment(-1.4, 0.0),
                        image: new AssetImage(
                          'graphics/twitter_icon.png',
                        ))),
                child: Text(
                  '       Sign in with twitter',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          )),
      width: 250.0,
    );
  }
}
