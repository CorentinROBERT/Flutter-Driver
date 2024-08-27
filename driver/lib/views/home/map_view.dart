import 'dart:async';
import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:driver/helpers/network_helper.dart';
import 'package:driver/models/line_string.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  apple.AppleMapController? mapController;
  Location location = Location();
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  final Completer<google.GoogleMapController> _controller =
      Completer<google.GoogleMapController>();
  Set<google.Polyline> googlePolyLines = {};
  Set<apple.Polyline> applePolyLines = {};

  final List<apple.LatLng> applePolyPoints = [];
  final List<google.LatLng> googlePolyPoints = [];

  static const google.CameraPosition _kGooglePlex = google.CameraPosition(
    target: google.LatLng(48.866667, 2.333333),
    zoom: 5,
  );

  static const google.CameraPosition _kLake = google.CameraPosition(
      bearing: 192.8334901395799,
      target: google.LatLng(37.43296265331129, -122.08832357078792),
      tilt: 0.0,
      zoom: 19.151926040649414);

  @override
  void initState() {
    initCurrentPosition();
    getJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Platform.isAndroid
            ? google.GoogleMap(
                mapType: google.MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                polylines: googlePolyLines,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (google.GoogleMapController controller) {
                  _controller.complete(controller);
                },
              )
            : apple.AppleMap(
                mapType: apple.MapType.standard,
                compassEnabled: true,
                trafficEnabled: true,
                myLocationButtonEnabled: true,
                polylines: applePolyLines,
                myLocationEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: const apple.CameraPosition(
                    target: apple.LatLng(48.866667, 2.333333), zoom: 5.0),
              ),
      ],
    );
  }

  void _onMapCreated(apple.AppleMapController controller) {
    mapController = controller;
  }

  Future<void> _goToTheLake(google.CameraPosition pos) async {
    final google.GoogleMapController controller = await _controller.future;
    await controller.animateCamera(google.CameraUpdate.newCameraPosition(pos));
  }

  void initCurrentPosition() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      var currentLocation = await location.getLocation();
    } catch (e) {
      print(e);
    }
  }

  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    NetworkHelper network = NetworkHelper(
      //Cannes lat: 43.552847 lng: 7.017369
      //Nice lat: 43.700000 lng: 7.250000
      startLat: 43.552847,
      startLng: 7.017369,
      endLat: 43.700000,
      endLng: 7.250000,
    );

    try {
      // getData() returns a json Decoded data
      var data = await network.getData();

      // We can reach to our desired JSON data manually as following
      LineString ls =
          LineString(data['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        Platform.isAndroid
            ? googlePolyPoints
                .add(google.LatLng(ls.lineString[i][1], ls.lineString[i][0]))
            : applePolyPoints
                .add(apple.LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }
      setPolyLines();
    } catch (e) {
      print(e);
    }
  }

  setPolyLines() {
    if (Platform.isAndroid) {
      google.Polyline polylineG = google.Polyline(
        polylineId: const google.PolylineId("polyline"),
        color: Colors.lightBlue,
        points: googlePolyPoints,
      );
      googlePolyLines.add(polylineG);
    } else {
      apple.Polyline polylineA = apple.Polyline(
        polylineId: apple.PolylineId("polyline"),
        color: Colors.lightGreen,
        points: applePolyPoints,
      );
      applePolyLines.add(polylineA);
    }
    setState(() {});
  }
}
