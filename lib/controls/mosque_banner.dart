import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MosqueBanner extends StatelessWidget {
  const MosqueBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: FractionalOffset.center,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black38,
                Colors.transparent,
              ],
            ),
          ),
          child: new CachedNetworkImage(
            imageUrl:
                "https://i2-prod.birminghammail.co.uk/incoming/article7775520.ece/ALTERNATES/s615/green-lane-mosque.jpg",
            placeholder: Container(
              height: 150.0,
              alignment: FractionalOffset.center,
              child: Container(
                child: new CircularProgressIndicator(),
              ),
            ),
            errorWidget: new Icon(Icons.error),
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          child: Text(
            "Green Lane Masjid",
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        )
      ],
    );
  }
}
