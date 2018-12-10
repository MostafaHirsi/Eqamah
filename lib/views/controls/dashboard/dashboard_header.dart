import 'package:carousel_pro/carousel_pro.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:eqamah/views/pages/prayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader(
      {Key key,
      @required this.headerImageSrc,
      @required this.headerText,
      @required this.prayer,
      @required this.prayers})
      : super(key: key);

  final String headerImageSrc;
  final String headerText;
  final PrayerTime prayer;
  final List<PrayerTime> prayers;

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          child: Stack(
            children: <Widget>[
              Container(
                foregroundDecoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                      Colors.black38,
                      Colors.black38,
                      Colors.black38,
                      Colors.black38,
                    ],
                        stops: [
                      0.0,
                      0.00,
                      0.0,
                      5.0
                    ],
                        begin: FractionalOffset.bottomCenter,
                        end: FractionalOffset.topCenter,
                        tileMode: TileMode.repeated)),
                child: new SizedBox(
                  height: 250.0,
                  // child: new Carousel(
                  //   overlayShadow: false,
                  //   dotSize: 4.0,
                  //   dotBgColor: Colors.transparent,
                  //   autoplay: false,
                  //   images: [
                  //     new ExactAssetImage(headerImageSrc),
                  //     new ExactAssetImage('graphics/kaba.jpg'),
                  //     new ExactAssetImage('graphics/mosque_night.jpg'),
                  //   ],
                  // )
                  child: Image.asset(headerImageSrc),
                ),
              ),
              Container(
                height: 250.0,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: prayers.length,
                  itemBuilder: (context, index) {
                    return buildPrayer(prayers[index], context);
                  },
                ),
              )
            ],
          ),
          alignment: Alignment(-0.9, 1.0),
        ),
      ],
    );
  }

  Container buildContainer(String formatted) {
    return Container(
        alignment: Alignment(0.0, 0.0),
        height: 250.0,
        child: formatted != ""
            ? Text("${prayer.prayerName}: $formatted",
                style: TextStyle(color: Colors.white, fontSize: 30.0))
            : new CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ));
  }

  Widget buildPrayer(PrayerTime prayTimeObj, BuildContext context) {
    var formatter = new DateFormat('Hm');
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return PrayerTimePage(prayers: prayers, key: key);
        }));
      },
      child: Container(
          width: 80.0,
          alignment: Alignment(0.0, 0.0),
          height: 250.0,
          child: prayTimeObj != null
              ? Text(
                  "${prayTimeObj.prayerName}: ${formatter.format(prayTimeObj.prayerTime)}",
                  style: TextStyle(color: Colors.white, fontSize: 30.0))
              : new CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )),
    );
  }
}
