import 'package:eqamah/bloc/home_bloc.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class PrayersFullScreen extends StatefulWidget {
  const PrayersFullScreen() : super();

  @override
  _PrayersFullScreenState createState() => _PrayersFullScreenState();
}

class _PrayersFullScreenState extends State<PrayersFullScreen> {
  DateTime selectedDate;
  List<PrayerModel> prayers = null;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text(eventListName),
          actions: <Widget>[
            Theme(
                data: ThemeData(
                    primaryColor: Colors.blueGrey,
                    primarySwatch: Colors.blueGrey),
                child: new Builder(
                  builder: (contextOne) => IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          DateTime picked = await showDatePicker(
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 31)),
                              context: contextOne);
                          if (picked != null && picked != selectedDate)
                            setState(() async {
                              selectedDate = picked;
                              await prayerTimeBloc.fetchAllPrayers();
                              this.prayers =
                                  prayerTimeBloc.mosqueModel.prayerTimes;
                            });
                        },
                      ),
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: prayerTimeBloc.fetchAllPrayers(),
          builder: (buildContext, snapshot) {
            if (snapshot.hasData) {
              this.prayers = prayerTimeBloc.mosqueModel.prayerTimes;
              return ListView.builder(
                  itemBuilder: buildPrayerItem, itemCount: this.prayers.length);
            } else {
              return Container(
                margin: EdgeInsets.all(
                  10.0,
                ),
                child: CircularProgressIndicator(),
              );
            }
          },
        )

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

  Widget buildPrayerItem(BuildContext context, int index) {
    PrayerModel prayer = this.prayers[index];

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
            Container(
                child: Text(
              prayer.prayerName,
              style: TextStyle(color: Colors.black),
            )),
            Container(
                child: Text(
              formatter.format(prayer.prayerTime),
              style: TextStyle(color: Colors.black),
            )),
          ],
        ));
  }
}
