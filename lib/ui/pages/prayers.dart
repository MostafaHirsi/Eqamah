import 'package:eqamah/bloc/home_bloc.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PrayersFullScreen extends StatelessWidget {
  final List<PrayerModel> prayers;
  const PrayersFullScreen({this.prayers}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemBuilder: buildPrayerItem, itemCount: prayers.length)

        //         margin: EdgeInsets.symmetric(vertical: 0.0),
        //         alignment: FractionalOffset.center,
        //         child: StreamBuilder(
        //           stream: prayerTimeBloc.allPrayers,
        //           builder: (context, AsyncSnapshot<DashboardMosqueModel> snapshot) {
        //             if (snapshot.hasData) {
        //               DashboardMosqueModel dashboardMosqueModel = snapshot.data;
        //               PrayerModel prayerTime =
        //                   getClosestPrayer(dashboardMosqueModel);
        //               var formatter = new DateFormat('HH:mm');
        //               return Column(
        //                 children: <Widget>[
        //                   Container(
        //                     margin: EdgeInsets.symmetric(vertical: 10.0),
        //                     alignment: FractionalOffset.center,
        //                     child: Text(
        //                       prayerTime.prayerName,
        //                       style: TextStyle(fontSize: 28.0),
        //                       textAlign: TextAlign.center,
        //                     ),
        //                   ),
        //                   Text(
        //                     formatter.format(prayerTime.prayerTime),
        //                     style: TextStyle(fontSize: 26.0),
        //                     textAlign: TextAlign.center,
        //                   ),
        //                 ],
        //               );
        //             } else if (snapshot.hasError) {
        //               return Text(snapshot.error.toString());
        //             }
        //             return Center(child: CircularProgressIndicator());
        //           },
        //         ),
        );
  }

  // List<PrayerModel> getClosestPrayer(DashboardMosqueModel dashboardMosqueModel) {
  //     dashboardMosqueModel.prayerTimes.removeWhere(removeNonPrayers);
  //     return dashboardMosqueModel.prayerTimes;
  //   }

  //   bool removeNonPrayers(prayer) {
  //     return prayer.prayerName == "Sunrise" ||
  //         prayer.prayerName == "Sunset" ||
  //         prayer.prayerName == "Imsak" ||
  //         prayer.prayerName == "Midnight";
  //   }

  Widget buildPrayerItem(BuildContext context, int index) {
    PrayerModel prayer = prayers[index];

    return new PrayerItem(
      prayer: prayer,
    );
  }
}

class PrayerItem extends StatelessWidget {
  
  final PrayerModel prayer;
  const PrayerItem({this.prayer}) : super();

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('HH:mm');
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
                Container(child: Text(prayer.prayerName, style: TextStyle(color: Colors.black),)),
                Container(child: Text(formatter.format(prayer.prayerTime), style: TextStyle(color: Colors.black),)),
      ],
    ));
  }
}
