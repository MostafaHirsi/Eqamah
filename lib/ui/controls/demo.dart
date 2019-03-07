import 'dart:async';

import 'package:eqamah/api/google_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math' as Math;
import 'package:location/location.dart' as GPSLocation;

import 'package:http/http.dart';

class MapsPage extends StatefulWidget {
  @override
  State createState() => MapsPageState();
}

class MapsPageState extends State<MapsPage> {
  GoogleMapController mapController;
  String searchTerms = "";
  TextEditingController searchController = new TextEditingController();
  var location = new GPSLocation.Location();
  final places =
      new GoogleMapsPlaces("AIzaSyAj04OTDCjEcRdb_Bt-0pPmTzaMijV65cg");
  bool focused = false;
  double _radius = 800.0;
  Offset offset = new Offset(0.0, -200.0);
  PlacesSearchResult _selectedPlace;

  bool _isVisible = true;

  PlacesSearchResponse _placesSearchResponse;

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = new Set();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

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
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: _onMapCreated,
          markers: markers,
          // compassEnabled: true,
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
        // Container(
        //   child: MosqueInfoCard(
        //     isVisible: _isVisible,
        //     selectedPlace: _selectedPlace,
        //   ),
        // )
      ],
    ));
  }

  void searchNearby(searchTerms) async {
    // todo
    // mapController.clearMarkers();
    Future<Map<String, double>> currentLocation = location.getLocation();
    currentLocation.then((obj) async {
      var lat = obj["latitude"];
      var long = obj["longitude"];
      _placesSearchResponse = await places.searchNearbyWithRadius(
          Location(lat, long), 5000,
          keyword: "mosque", name: searchTerms);
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          new LatLng(lat, long),
          getZoomLevel(_radius),
        ),
      );
      populateMarkers(_placesSearchResponse);
    });
  }

  void populateMarkers(PlacesSearchResponse placesSearchResponse) async {
    if (placesSearchResponse.isOkay) {
      markers.clear();
      for (PlacesSearchResult searchResult in placesSearchResponse.results) {
        // Marker marker = await _addMarker(searchResult);
        Location location = searchResult.geometry.location;
        Marker marker = new Marker(
          markerId: new MarkerId(
            searchResult.placeId,
          ),
          onTap: () {
            // print(searchResult.name + "@£");
            _selectedPlace = searchResult;
            // setState(() {
            //   _isVisible = true;
            // });
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return MosqueInfoCard(
                  isVisible: true,
                  selectedPlace: _selectedPlace,
                );
              },
            );
          },
          position: LatLng(location.lat, location.lng),
        );
        markers.add(marker);
      }
    }
  }

  double getZoomLevel(double radius) {
    int zoomLevel = 0;
    double scale = radius / 500;
    zoomLevel = (16 - Math.log(scale) / Math.log(2)).toInt();
    return zoomLevel - 2.0;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
    Future<Map<String, double>> currentLocation = location.getLocation();
    currentLocation.then((obj) async {
      var lat = obj["latitude"];
      var long = obj["longitude"];
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(
          new LatLng(lat, long),
          getZoomLevel(_radius),
        ),
      );
      // mapController.addListener(() {
      //   SystemChannels.textInput.invokeMethod('TextInput.hide');
      // });
    });
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
    return Container(
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
                builder: (BuildContext context, AsyncSnapshot<dynamic> image) {
                  if (image != null && image.hasData) {
                    return image.data; // image is ready
                  } else {
                    return new Container(); // placeholder
                  }
                },
              )
            ],
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
