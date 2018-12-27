import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            alignment: FractionalOffset.center,
            child: Text(
              "Green Lane Masjid",
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            alignment: FractionalOffset.center,
            child: Text(
              "Maghrib",
              style: TextStyle(fontSize: 28.0),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            alignment: FractionalOffset.center,
            child: Text(
              "16:53",
              style: TextStyle(fontSize: 26.0),
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            color: Colors.white,
            child: Text(
              "View All",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
