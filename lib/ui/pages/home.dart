import 'package:cached_network_image/cached_network_image.dart';
import 'package:eqamah/bloc/home_bloc.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:eqamah/ui/pages/prayers.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "https://hdqwalls.com/download/mosque-ap-1125x2436.jpg";
  List<PrayerModel> todaysPrayers;
  String closestPrayer = "";
  FlareController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // prayerTimeBloc.fetchAllPrayers();

  PrayerModel prayerTime =
      getClosestPrayer(prayerTimeBloc.mosqueModel);
  
  todaysPrayers = prayerTimeBloc.mosqueModel.prayerTimes;
  closestPrayer = prayerTime.prayerName;

  var formatter = new DateFormat('HH:mm');



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
        child: Stack(
          children: <Widget>[
            new FlareActor(
              "graphics/prayerAnimations.flr",
              fit: BoxFit.fitWidth,
              animation: closestPrayer,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.mosque),
                      onPressed: () {},
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    alignment: FractionalOffset.center,
                    child: Text(
                      "Green Lane Masjid",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 0.0),
                    alignment: FractionalOffset.center,
                    child: Column(
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
                              RaisedButton(
                                color: Colors.white,
                                child: Text(
                                  "View All",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => PrayersFullScreen(
                                              prayers: todaysPrayers)));
                                },
                              )
                            ],
                          ),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  PrayerModel getClosestPrayer(DashboardMosqueModel dashboardMosqueModel) {
    dashboardMosqueModel.prayerTimes.removeWhere(removeNonPrayers);

  DateTime currentTime =DateTime.now();
  
  for (PrayerModel prayer in dashboardMosqueModel.prayerTimes){
    if(currentTime.isBefore(prayer.prayerTime)){
      return prayer;
    } else{
      continue;
    }
  }
  //Get fajr for the next day
  return prayerTimeBloc.mosqueModelTomorrow.prayerTimes[0];





    // PrayerModel closestPrayer = dashboardMosqueModel.prayerTimes.first;
    // for (PrayerModel prayer in dashboardMosqueModel.prayerTimes) {
    //   if (closestPrayer.prayerTime.isBefore(prayer.prayerTime)) {
    //     closestPrayer = prayer;
    //   } else {
    //     continue;
    //   }
    // }
    // return closestPrayer;
  }


  bool removeNonPrayers(prayer) {
    return prayer.prayerName == "Sunrise" ||
        prayer.prayerName == "Sunset" ||
        prayer.prayerName == "Imsak" ||
        prayer.prayerName == "Midnight";
  }
}
