import 'package:cached_network_image/cached_network_image.dart';
import 'package:eqamah/ui/controls/mosque_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          flex: 45,
          child: new MosqueBanner(),
        ),
        Flexible(
          flex: 55,
          child: ListView(
            children: <Widget>[
              new Card(
                shape: Border.all(color: Colors.grey.shade400),
                margin: EdgeInsets.all(10.0),
                elevation: 0.0,
                child: Container(
                  height: 100.0,
                  margin: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Text(
                          "Services",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      Flexible(
                        flex: 10,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Icon(
                                      FontAwesomeIcons.book,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text(
                                    "Quran",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Column(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Icon(
                                      FontAwesomeIcons.bookDead,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Text(
                                    "Funeral",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              new Card(
                shape: Border.all(color: Colors.grey.shade400),
                margin: EdgeInsets.all(10.0),
                elevation: 0.0,
                child: Container(
                  height: 130.0,
                  margin: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Contact",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text.rich(
                        TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: "20 Green Lane\n"),
                            TextSpan(text: "Small Heath\n"),
                            TextSpan(text: "Birmingham\n"),
                            TextSpan(text: "B9 5DB\n"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              new Card(
                shape: Border.all(color: Colors.grey.shade400),
                margin: EdgeInsets.all(10.0),
                elevation: 0.0,
                child: Container(
                  height: 100.0,
                  margin: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Text(
                          "Facilities",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Flexible(
                        flex: 3,
                        child: ListView(
                          padding: EdgeInsets.all(3.0),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Icon(
                                  Icons.local_parking,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Icon(
                                  FontAwesomeIcons.pray,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Icon(
                                  Icons.wifi,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
