import 'dart:async';
import 'package:eqamah/api/api_service.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:eqamah/views/controls/dashboard/dashboard_card.dart';
import 'package:eqamah/views/controls/dashboard/dashboard_drawer.dart';
import 'package:eqamah/views/controls/dashboard/dashboard_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  String mosqueButtonText = 'Mosques';
  String mosqueButtonImageSrc = 'graphics/mosque.png';
  String headerImageSrc = 'graphics/turkish_mosque_rectangle.jpg';
  String headerText = 'Blue Mosque';
  double lat;
  double long;

  void initState() {
    super.initState();
  }

  getLatLong() async {
    var location = new Location();
    Future<Map<String, double>> currentLocation = location.getLocation();
    currentLocation.then((obj) {
      lat = obj["latitude"];
      long = obj["longitude"];
    });
  }

  @override
  Widget build(BuildContext context) {
    getLatLong();
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xFFf8653c),
        title: Text(
          "إقامة‎",
          style: TextStyle(
              fontSize: 35.0,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      drawer: new DashboardDrawer(),
      body: new SingleDashBoard(
        headerImageSrc: headerImageSrc,
        headerText: headerText,
        lat: lat,
        long: long,
      ),
    );
  }
}

class SingleDashBoard extends StatelessWidget {
  const SingleDashBoard({
    Key key,
    @required this.headerImageSrc,
    @required this.headerText,
    @required this.lat,
    @required this.long,
  }) : super(key: key);

  final String headerImageSrc;
  final String headerText;
  final double lat;
  final double long;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          FutureBuilder<DashboardMosqueModel>(
            future: get(
                '/timings/1398332113?latitude=${51.508515}&longitude=${-0.1254872}&method=2'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var i = 0; i < snapshot.data.prayerTimes.length; i++) {
                  PrayerTime prayer = snapshot.data.prayerTimes[i];

                  var formatter = new DateFormat('Hms');
                  String formatted = formatter.format(prayer.prayerTime);
                  String formatted1 = formatter.format(DateTime.now());
                  if (prayer.prayerTime.isAfter(DateTime.now())) {
                    return new DashboardHeader(
                        headerImageSrc: headerImageSrc,
                        headerText: headerText,
                        prayer: prayer);
                  }
                }
                var formatter = new DateFormat('Hms');
                String formatted =
                    formatter.format(snapshot.data.prayerTimes[0].prayerTime);
                return Text("Fajr: $formatted");
              } else if (snapshot.hasError) {
                return new DashboardHeader(
                    headerImageSrc: headerImageSrc,
                    headerText: headerText,
                    prayer: null);
                // return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return new DashboardHeader(
                    headerImageSrc: headerImageSrc,
                    headerText: headerText,
                    prayer: null);
            },
          ),
          GridView(
            padding: EdgeInsets.all(5.0),
            shrinkWrap: true,
            children: <Widget>[
              new DashboardCard(
                  imageSrc: 'graphics/contacts.png', cardTitle: 'Contacts'),
              new DashboardCard(
                  imageSrc: 'graphics/event.png', cardTitle: 'Events'),
              new DashboardCard(
                  imageSrc: 'graphics/time_icon.png', cardTitle: 'Salat Times')
            ],
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          )
        ],
      ),
    );
  }
}

//AIzaSyDoEMHqWxH625fr45zJDioOflyHWf1soBI
