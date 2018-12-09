import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:map_view/map_view.dart';

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
    var _mapView = new MapView();
    _mapView.show(
        new MapOptions(showUserLocation: true, showMyLocationButton: true));
    _mapView.centerLocation.then((centerLocation) {
      _mapView.setCameraPosition(new CameraPosition(centerLocation, 3.0));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}
