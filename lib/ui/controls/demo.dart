import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eqamah/api/google_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:math' as Math;
import 'package:location/location.dart' as GPSLocation;
import 'package:url_launcher/url_launcher.dart';
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
        IgnorePointer(
          ignoring: _selectedPlace == null,
          child: FutureBuilder<Map<String, double>>(
            future: location.getLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var lat = snapshot.data["latitude"];
                var long = snapshot.data["longitude"];
                return GoogleMap(
                  mapType: MapType.normal,
                  trackCameraPosition: false,
                  scrollGesturesEnabled: _selectedPlace == null,
                  rotateGesturesEnabled: _selectedPlace == null,
                  tiltGesturesEnabled: _selectedPlace == null,
                  zoomGesturesEnabled: _selectedPlace == null,
                  compassEnabled: _selectedPlace == null,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat, long),
                    zoom: 14.4746,
                  ),
                  onMapCreated: _onMapCreated,
                  markers: markers,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
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
      setState(() {});
    });
  }

  void populateMarkers(PlacesSearchResponse placesSearchResponse) async {
    if (placesSearchResponse.isOkay) {
      markers.clear();
      for (PlacesSearchResult searchResult in placesSearchResponse.results) {
        // Marker marker = await _addMarker(searchResult);
        Location location = searchResult.geometry.location;
        Marker marker = new Marker(
          infoWindow: InfoWindow(
            title: searchResult.name,
            snippet: searchResult.vicinity,
            onTap: () async {
              // print(searchResult.name + "@£");
              _selectedPlace = searchResult;
              // setState(() {
              //   _isVisible = true;
              // });
              await showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return MosquePlaceDetail(
                    selectedPlace: _selectedPlace,
                  );
                },
              );
              setState(() {
                _selectedPlace = null;
              });
            },
          ),
          markerId: new MarkerId(
            searchResult.placeId,
          ),
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

class MosquePlaceDetail extends StatefulWidget {
  final PlacesSearchResult selectedPlace;

  MosquePlaceDetail({Key key, this.selectedPlace}) : super(key: key);
  @override
  MosquePlaceDetailState createState() => MosquePlaceDetailState(
        selectedPlace: selectedPlace,
      );
}

class MosquePlaceDetailState extends State<MosquePlaceDetail> {
  final PlacesSearchResult selectedPlace;
  final places =
      new GoogleMapsPlaces("AIzaSyAj04OTDCjEcRdb_Bt-0pPmTzaMijV65cg");
  Uint8List imageBytes = null;

  MosquePlaceDetailState({this.selectedPlace});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Container(
        constraints: BoxConstraints.expand(height: 200.0),
        alignment: Alignment(0.0, 1.0),
        child: Card(
          shape: BeveledRectangleBorder(),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                height: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 5.0),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.home,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.grey.shade300,
                height: 1.0,
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                child: Text(
                  selectedPlace?.name ?? "",
                  style: Theme.of(context).textTheme.headline,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              FutureBuilder(
                future: places.getDetailsByPlaceId(selectedPlace.placeId),
                builder: (_, mosqueSnapshot) {
                  if (mosqueSnapshot.hasData) {
                    PlacesDetailsResponse response = mosqueSnapshot.data;
                    PlaceDetails placeDetails = response.result;
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(
                            placeDetails.formattedPhoneNumber ?? "N/A",
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.place),
                          title: Text(
                            placeDetails.formattedAddress ?? "N/A",
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.web_asset),
                          title: InkWell(
                            child: new Text(
                              placeDetails.website,
                              style: TextStyle(
                                color: Color(0xFF663366),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () => launch(placeDetails.website),
                          ),
                        ),
                        SizedBox(
                            height: 200.0,
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: placeDetails.photos.length,
                              itemBuilder: (_, index) {
                                Photo placePhoto = placeDetails.photos[index];
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.chevron_left,
                                          color: index > 0
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                    Flexible(
                                      flex: 8,
                                      child: Container(
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitHeight,
                                          placeholder: Icon(
                                            Icons.picture_in_picture,
                                            size: 400.0,
                                          ),
                                          imageUrl: buildPhotoURL(
                                              placePhoto.photoReference),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.chevron_right,
                                          color:
                                              index < placeDetails.photos.length
                                                  ? Colors.black
                                                  : Colors.grey,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ))
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              // Container(
              //   child: new FutureBuilder(
              //     future: loadImage(),
              //     builder:
              //         (BuildContext context, AsyncSnapshot<Uint8List> image) {
              //       if (imageBytes != null) {
              //         return Image.memory(
              //           imageBytes,
              //           alignment: Alignment.topCenter,
              //         );
              //       } else {
              //         return new Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String buildPhotoURL(String photoReference) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=${photoReference}&key=AIzaSyAj04OTDCjEcRdb_Bt-0pPmTzaMijV65cg";
  }

  Future<Uint8List> loadImage() async {
    if (imageBytes == null) {
      dynamic response = await GoogleServices.get(
          200, selectedPlace?.photos?.first?.photoReference);
      imageBytes = response.bodyBytes;
    }
    return imageBytes;
  }
}
