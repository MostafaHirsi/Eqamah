import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return Scaffold();
  }
}