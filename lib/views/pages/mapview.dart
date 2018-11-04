import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapViewPage extends StatefulWidget {
  @override
  _MapViewState createState() {
    return _MapViewState();
  }
}

class _MapViewState extends State<MapViewPage> {
    var uri;

  void initState() {
    super.initState(); 
    showMap();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
    );
  }

  void showMap() {
  }
}
