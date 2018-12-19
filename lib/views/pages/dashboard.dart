import 'dart:async';
import 'package:eqamah/api/api_service.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:eqamah/views/controls/dashboard/dashboard_card.dart';
import 'package:eqamah/views/controls/dashboard/dashboard_drawer.dart';
import 'package:eqamah/views/controls/dashboard/dashboard_header.dart';
import 'package:eqamah/views/pages/demo_map.dart';
import 'package:eqamah/views/pages/information.dart';
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
    double lat, long;
    var location = new Location();
    Future<Map<String, double>> currentLocation = location.getLocation();
    currentLocation.then((obj) {
      lat = obj["latitude"];
      long = obj["longitude"];
    });

    Future<DashboardMosqueModel> future = location.getLocation().then((obj) {
      lat = obj["latitude"];
      long = obj["longitude"];
      return getPrayerTimes(
          '/timings?latitude=${lat.toStringAsPrecision(7)}&longitude=${long.toStringAsPrecision(7)}&method=2&timezonestring=Europe/London');
    });
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        children: <Widget>[
          FutureBuilder<DashboardMosqueModel>(
              future: future, builder: buildFutureBuilder),
          GridView(
            padding: EdgeInsets.all(5.0),
            shrinkWrap: true,
            children: <Widget>[
              new DashboardCard(
                imageSrc: 'graphics/event.png',
                cardTitle: 'Events',
                pageToNavigate: MapsPage(),
              ),
              new DashboardCard(
                imageSrc: 'graphics/event.png',
                cardTitle: 'Information',
                pageToNavigate: MosqueInformationPage(),
              ),
              new DashboardCard(
                imageSrc: 'graphics/event.png',
                cardTitle: 'Current Mosques',
                pageToNavigate: MapsPage(),
              ),
              new DashboardCard(
                imageSrc: 'graphics/event.png',
                cardTitle: 'Explore',
                pageToNavigate: MapsPage(),
              ),
            ],
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          )
        ],
      ),
    );
  }

  Widget buildFutureBuilder(context, snapshot) {
    if (snapshot.hasData) {
      return new DashboardHeader(
        headerImageSrc: headerImageSrc,
        headerText: headerText,
        prayer: snapshot.data.prayerTimes[0],
        prayers: snapshot.data.prayerTimes,
      );
    } else if (snapshot.hasError) {
      return new DashboardHeader(
        headerImageSrc: headerImageSrc,
        headerText: headerText,
        prayer: null,
        prayers: [],
      );
    }

    // By default, show a loading spinner
    return new DashboardHeader(
      headerImageSrc: headerImageSrc,
      headerText: headerText,
      prayer: null,
      prayers: [],
    );
  }
}
