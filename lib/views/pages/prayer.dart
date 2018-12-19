import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PrayerTimePage extends StatefulWidget {
  final List<PrayerTime> prayers;

  const PrayerTimePage({Key key, this.prayers}) : super(key: key);

  @override
  _PrayerTimePageState createState() => _PrayerTimePageState(prayers);
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  final List<PrayerTime> prayers;

  _PrayerTimePageState(this.prayers);

  @override
  Widget build(BuildContext context) {
    DateTime todaysTime = DateTime.now();
    var formatter = new DateFormat.MMMMEEEEd().addPattern("\n").add_jm();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  color: Colors.teal,
                  padding: EdgeInsets.all(50.0),
                  child: Text(
                    formatter.format(todaysTime),
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: BackButton(
                    color: Colors.white,
                  )),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: prayers.length,
            itemBuilder: buildRow,
          ),
        ],
      ),
    );
  }

  Widget buildRow(context, index) {
    DateFormat dateFormat = new DateFormat().add_jm();
    PrayerTime prayerTime = prayers[index];

    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade300,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              prayerTime.prayerName,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            width: 100.0,
            alignment: FractionalOffset.center,
            color: Colors.black87,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              dateFormat.format(prayerTime.prayerTime),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
