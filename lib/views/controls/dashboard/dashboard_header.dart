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
    PageController _pageController = PageController();
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
                  child: Image.asset(headerImageSrc),
                ),
              ),
              Container(
                height: 250.0,
                child: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: prayers.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Opacity(
                          opacity: _pageController.page > 0 ? 1.0 : 0.0,
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.arrow_left),
                            onPressed: () {
                              _pageController.previousPage(
                                  curve: Curves.bounceOut,
                                  duration: Duration(milliseconds: 500));
                            },
                          ),
                        ),
                        buildPrayer(prayers[index], context),
                        Opacity(
                          opacity: _pageController.page < prayers.length - 1
                              ? 1.0
                              : 0.0,
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.arrow_right),
                            onPressed: () {
                              _pageController.nextPage(
                                  curve: Curves.bounceOut,
                                  duration: Duration(milliseconds: 500));
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
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
    var formatter = new DateFormat().add_jm();
    return InkWell(
      splashColor: Colors.white,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return PrayerTimePage(prayers: prayers, key: key);
        }));
      },
      child: Container(
          width: 180.0,
          alignment: Alignment(0.0, 0.0),
          height: 250.0,
          child: prayTimeObj != null
              ? Text(
                  "${prayTimeObj.prayerName} \n ${formatter.format(prayTimeObj.prayerTime)}",
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                  textAlign: TextAlign.center,
                )
              : new CircularProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                )),
    );
  }
}
