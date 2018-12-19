import 'package:eqamah/views/pages/mapview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key key,
    @required this.imageSrc,
    @required this.cardTitle,
    @required this.pageToNavigate,
  }) : super(key: key);

  final String imageSrc;
  final String cardTitle;
  final Widget pageToNavigate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Card(
        elevation: 10.0,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => pageToNavigate));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                imageSrc,
                height: 40.0,
              ),
              Text(
                cardTitle,
                style: TextStyle(fontSize: 13.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
