import 'package:eqamah/api/google_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math' as Math;

import 'package:http/http.dart';

class MapsPage extends StatefulWidget {
  @override
  State createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  GoogleMapController mapController;
  String searchTerms = "";
  TextEditingController searchController = new TextEditingController();
  final places =
      new GoogleMapsPlaces("AIzaSyAj04OTDCjEcRdb_Bt-0pPmTzaMijV65cg");
  bool focused = false;
  double _radius = 800.0;
  Offset offset = new Offset(0.0, -200.0);
  PlacesSearchResult _selectedPlace;

  bool _isVisible = false;

  PlacesSearchResponse _placesSearchResponse;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
        ),
        Container(
          alignment: Alignment(1.0, -1.0),
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            onTap: () {
              setState(() {
                focused = true;
              });
            },
            onSubmitted: searchNearby,
            autofocus: false,
            controller: searchController,
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              labelText: "Search for a mosque...",
              suffixIcon: Icon(Icons.search),
              filled: focused,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade800)),
            ),
          ),
        ),
        Container(
          child: MosqueInfoCard(
            isVisible: _isVisible,
            selectedPlace: _selectedPlace,
          ),
        )
      ],
    ));
  }

  void searchNearby(searchTerms) async {
    mapController.clearMarkers();
    _placesSearchResponse = await places.searchNearbyWithRadius(
        Location(52.484277, -1.825472), 1500,
        keyword: "mosque", name: searchTerms);
    mapController.animateCamera(CameraUpdate.zoomTo(getZoomLevel(_radius)));
    populateMarkers(_placesSearchResponse);
  }

  void populateMarkers(PlacesSearchResponse placesSearchResponse) {
    if (placesSearchResponse.isOkay) {
      for (PlacesSearchResult searchResult in placesSearchResponse.results) {
        Location location = searchResult.geometry.location;
        MarkerOptions markerOptions = new MarkerOptions(
            position: new LatLng(location.lat, location.lng),
            icon: BitmapDescriptor.fromAsset("graphics/marker_icon.png"),
            consumeTapEvents: false);
        mapController.addMarker(markerOptions);
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });

    GoogleMapOptions googleMapOptions = new GoogleMapOptions(
        myLocationEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: true);
    mapController.updateMapOptions(googleMapOptions);
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      const CameraPosition(
        bearing: 270.0,
        target: LatLng(52.484277, -1.825472),
        tilt: 30.0,
        zoom: 17.0,
      ),
    ));

    mapController.addListener(() {
      setState(() {
        focused = false;
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _isVisible = false;
      });
    });

    mapController.onMarkerTapped.add(markerTapped);
  }

  markerTapped(Marker marker) {
    int index = int.parse(marker.id);
    setState(() {
      _selectedPlace = _placesSearchResponse.results[index];
      _isVisible = true;
    });
  }

  double getZoomLevel(double radius) {
    int zoomLevel = 0;
    double scale = radius / 500;
    zoomLevel = (16 - Math.log(scale) / Math.log(2)).toInt();
    return zoomLevel - 2.0;
  }
}

class MosqueInfoCard extends StatelessWidget {
  final bool isVisible;
  final PlacesSearchResult selectedPlace;

  const MosqueInfoCard(
      {Key key, @required this.isVisible, @required this.selectedPlace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: new Offset(0.0, isVisible && selectedPlace != null ? 0.0 : 200.0),
      child: Container(
        constraints: BoxConstraints.expand(),
        child: Container(
          constraints: BoxConstraints.expand(height: 200.0),
          alignment: Alignment(0.0, 1.0),
          child: Card(
            shape: BeveledRectangleBorder(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15.0),
                  child: Text(
                    selectedPlace?.name ?? "",
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
                Container(
                  child: Text(
                    selectedPlace?.types?.first ?? "",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                new FutureBuilder(
                  future: _loadImage(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> image) {
                    // if (image != null && image.hasData) {
                    //   return image.data; // image is ready
                    // } else {
                    //   return new Container(); // placeholder
                    // }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loadImage() async {
    dynamic response = await GoogleServices.get(
        200, selectedPlace?.photos?.first?.photoReference);
  }
}
