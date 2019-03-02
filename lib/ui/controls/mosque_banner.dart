import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MosqueBanner extends StatelessWidget {
  final String bannerTitle;
  final String bannerImg;
  const MosqueBanner({
    Key key,
    this.bannerTitle,
    this.bannerImg,
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
              bannerImg,
            placeholder: Container(
              height: 300.0,
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
            vertical: 40.0,
            horizontal: 10.0,
          ),
          child: Text(
            bannerTitle,
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        )
      ],
    );
  }
}
