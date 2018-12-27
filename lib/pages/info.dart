import 'package:cached_network_image/cached_network_image.dart';
import 'package:eqamah/controls/mosque_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      direction: Axis.vertical,
      children: <Widget>[
        new MosqueBanner(),
        new Card(
          shape: Border.all(color: Colors.grey.shade400),
          margin: EdgeInsets.all(10.0),
          elevation: 0.0,
          child: Container(
            height: 100.0,
            margin: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(
              "Services",
            ),
          ),
        )
      ],
    );
  }
}
