import 'package:cached_network_image/cached_network_image.dart';
import 'package:eqamah/bloc/home_bloc.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:eqamah/ui/pages/prayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "https://hdqwalls.com/download/mosque-ap-1125x2436.jpg";

  @override
  Widget build(BuildContext context) {
    prayerTimeBloc.fetchAllPrayers();
    return Container(
      // color: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: new CachedNetworkImageProvider(
          //     url,
          //   ),
          //   fit: BoxFit.cover
          // ),
          ),
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
            margin: EdgeInsets.symmetric(vertical: 0.0),
            alignment: FractionalOffset.center,
            child: StreamBuilder(
              stream: prayerTimeBloc.allPrayers,
              builder: (context, AsyncSnapshot<DashboardMosqueModel> snapshot) {
                if (snapshot.hasData) {
                  DashboardMosqueModel dashboardMosqueModel = snapshot.data;
                  PrayerModel prayerTime =
                      getClosestPrayer(dashboardMosqueModel);
                  var formatter = new DateFormat('HH:mm');
                  return Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        alignment: FractionalOffset.center,
                        child: Text(
                          prayerTime.prayerName,
                          style: TextStyle(fontSize: 28.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        formatter.format(prayerTime.prayerTime),
                        style: TextStyle(fontSize: 26.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          RaisedButton(
            color: Colors.white,
            child: Text(
              "View All",
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => PrayersFullScreen()));
            },
          )
        ],
      ),
    );
  }

  PrayerModel getClosestPrayer(DashboardMosqueModel dashboardMosqueModel) {
    dashboardMosqueModel.prayerTimes.removeWhere(removeNonPrayers);
    PrayerModel closestPrayer = dashboardMosqueModel.prayerTimes.first;
    for (PrayerModel prayer in dashboardMosqueModel.prayerTimes) {
      if (closestPrayer.prayerTime.isBefore(prayer.prayerTime)) {
        closestPrayer = prayer;
      } else {
        continue;
      }
    }
    return closestPrayer;
  }

  bool removeNonPrayers(prayer) {
    return prayer.prayerName == "Sunrise" ||
        prayer.prayerName == "Sunset" ||
        prayer.prayerName == "Imsak" ||
        prayer.prayerName == "Midnight";
  }
}
