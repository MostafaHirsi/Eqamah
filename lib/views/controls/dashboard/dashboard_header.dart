
import 'package:carousel_pro/carousel_pro.dart';
import 'package:eqamah/models/dashboard/mosque_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader(
      {Key key,
      @required this.headerImageSrc,
      @required this.headerText,
      @required this.prayer})
      : super(key: key);

  final String headerImageSrc;
  final String headerText;
  final PrayerTime prayer;

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('Hm');
    String formatted = formatter.format(prayer.prayerTime);
    return new Stack(
      children: <Widget>[
        new Container(
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
              child: new Carousel(
                overlayShadow: false,
                dotSize: 4.0,
                dotBgColor: Colors.transparent,
                autoplay: false,
                images: [
                  new ExactAssetImage(headerImageSrc),
                  new ExactAssetImage('graphics/kaba.jpg'),
                  new ExactAssetImage('graphics/mosque_night.jpg'),
                ],
              )),
          alignment: Alignment(-0.9, 1.0),
        ),
        Container(
          constraints: BoxConstraints.expand(height: 250.0, width: 500.0),
          alignment: Alignment(-1.0, 1.0),
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 13.0),
          child: new Text(
            headerText,
            style: TextStyle(
              fontSize: 18.1,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.end,
          ),
        ),
        Container(
          constraints: BoxConstraints.expand(height: 250.0, width: 500.0),
          alignment: Alignment(0.0, 0.0),
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 15.0),
          child: new Text(
            formatted,
            style: TextStyle(
              fontSize: 35.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          constraints: BoxConstraints.expand(height: 250.0, width: 500.0),
          alignment: Alignment(0.0, 0.45),
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 15.0),
          child: new Text(
            prayer.prayerName,
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
