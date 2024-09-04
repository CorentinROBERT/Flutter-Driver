import 'dart:async';
import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple;
import 'package:driver/helpers/network_helper.dart';
import 'package:driver/models/enum/open_route_service_response.dart';
import 'package:driver/models/line_string.dart';
import 'package:driver/views/components/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  OpenRouteServiceResponse? orsResponse;
  LocationData? _locationData;
  apple.AppleMapController? mapController;
  final Completer<google.GoogleMapController> _controller =
      Completer<google.GoogleMapController>();
  Set<google.Polyline> googlePolyLines = {};
  Set<apple.Polyline> applePolyLines = {};

  final List<apple.LatLng> applePolyPoints = [];
  final List<google.LatLng> googlePolyPoints = [];

  Set<apple.Annotation> appleAnnotations = {};
  Set<google.Marker> googleMarkers = {};

  Set<apple.Circle> appleCircles = {};
  Set<google.Circle> googleCircles = {};

  bool isRemainingTimeModeSecond = true;
  String remainingTime = "";

  final double initLat = 48.866667;
  final double initLng = 2.333333;

  static const google.CameraPosition _kGooglePlex = google.CameraPosition(
    target: google.LatLng(48.866667, 2.333333),
    zoom: 5,
  );

  @override
  void initState() {
    initCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              SlidingUpPanel(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                minHeight: 130,
                color: Colors.white,
                body: Stack(
                  children: [
                    Platform.isAndroid
                        ? google.GoogleMap(
                            circles: googleCircles,
                            padding: const EdgeInsets.only(top: 50),
                            mapType: google.MapType.normal,
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true,
                            trafficEnabled: true,
                            polylines: googlePolyLines,
                            markers: googleMarkers,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated:
                                (google.GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          )
                        : apple.AppleMap(
                            circles: appleCircles,
                            padding: const EdgeInsets.only(top: 30),
                            mapType: apple.MapType.standard,
                            compassEnabled: true,
                            trafficEnabled: true,
                            myLocationButtonEnabled: true,
                            polylines: applePolyLines,
                            annotations: appleAnnotations,
                            myLocationEnabled: true,
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: apple.CameraPosition(
                                target: apple.LatLng(initLat, initLng),
                                zoom: 5.0),
                          ),
                    Visibility(
                      visible: remainingTime.isNotEmpty,
                      child: GestureDetector(
                        onTap: () {
                          swapRemainingTime();
                        },
                        child: SafeArea(
                          child: Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                orsResponse != null ? remainingTime : "",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                panel: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Information sur le point de retrait",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_up,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Migros Palettes")),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.place, color: Colors.blue),
                          const Expanded(
                            child: Text(
                                "54 Avenue des communes Réunis, 1212 Grand Lucy"),
                          ),
                          Container(
                            width: 40,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Prêt",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 40,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ActionSlider(),
        )
      ],
    );
  }

  void _onMapCreated(apple.AppleMapController controller) {
    mapController = controller;
  }

  void initCurrentPosition() async {
    try {
      Location location = Location();
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

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

      _locationData = await location.getLocation();
      print(
          "latitude : ${_locationData?.latitude} longitude : ${_locationData?.longitude}");

      getJsonData();
    } catch (e) {
      print(e);
    }
  }

  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format

    var endLat = 43.700000;
    var endLng = 7.250000;

    NetworkHelper network = NetworkHelper(
      //Cannes lat: 43.552847 lng: 7.017369
      //Nice lat: 43.700000 lng: 7.250000
      startLat: _locationData?.latitude ?? initLat,
      startLng: _locationData?.longitude ?? initLng,
      endLat: endLat,
      endLng: endLng,
    );

    try {
      var response = await network.getData();
      orsResponse = OpenRouteServiceResponse.fromJson(response);
      LineString ls =
          LineString(orsResponse!.features.first.geometry.coordinates);
      for (int i = 0; i < ls.lineString.length; i++) {
        Platform.isAndroid
            ? googlePolyPoints
                .add(google.LatLng(ls.lineString[i][1], ls.lineString[i][0]))
            : applePolyPoints
                .add(apple.LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }
      swapRemainingTime();
      setPolyLines();
      setMarkers(endLat, endLng);
      setCircles();
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
        color: Colors.lightBlue,
        points: applePolyPoints,
      );
      applePolyLines.add(polylineA);
    }
    setState(() {});
  }

  setMarkers(double endLat, double endLng) {
    if (Platform.isAndroid) {
      googleMarkers.add(google.Marker(
          infoWindow: const google.InfoWindow(title: "Test"),
          markerId: const google.MarkerId("EndOfPoint"),
          position: google.LatLng(endLat, endLng)));
    } else {
      appleAnnotations.add(apple.Annotation(
          infoWindow: const apple.InfoWindow(title: "test"),
          annotationId: apple.AnnotationId("EndOfPoint"),
          position: apple.LatLng(endLat, endLng)));
    }
    setState(() {});
  }

  String formatDuration(double durationInSeconds) {
    int hours = durationInSeconds ~/ 3600; // Integer division to get hours
    int minutes = (durationInSeconds % 3600) ~/ 60; // Get the remaining minutes
    int seconds = (durationInSeconds % 60).round(); // Get the remaining seconds
    return '${hours}h ${minutes}m ${seconds}s';
  }

  String formatRemainingDurationinHour(double durationInSeconds) {
    int hours = durationInSeconds ~/ 3600; // Integer division to get hours
    int minutes = (durationInSeconds % 3600) ~/ 60; // Get the remaining minutes
    int seconds = (durationInSeconds % 60).round(); // Get the remaining seconds
    return DateFormat("HH:mm").format(DateTime.now()
        .add(Duration(hours: hours, minutes: minutes, seconds: seconds)));
  }

  void swapRemainingTime() {
    if (isRemainingTimeModeSecond) {
      remainingTime =
          "Time remaining ${formatDuration(orsResponse!.features.first.properties.segments.first.duration ?? 0.0)}";
    } else {
      remainingTime =
          "Approx arrival time : ${formatRemainingDurationinHour(orsResponse!.features.first.properties.segments.first.duration ?? 0.0)}";
    }
    isRemainingTimeModeSecond = !isRemainingTimeModeSecond;
    setState(() {});
  }

  void setCircles() {
    if (Platform.isAndroid) {
      final google.Circle googleCircle = google.Circle(
        circleId: const google.CircleId("googleCircle"),
        consumeTapEvents: true,
        strokeColor: Colors.transparent,
        fillColor: Colors.pinkAccent.withOpacity(0.5),
        strokeWidth: 5,
        center: google.LatLng(_locationData?.latitude ?? initLat,
            _locationData?.longitude ?? initLng),
        radius: 200,
        onTap: () {},
      );
      googleCircles = {googleCircle};
    } else {
      final apple.Circle appleCircle = apple.Circle(
        circleId: apple.CircleId("googleCircle"),
        consumeTapEvents: true,
        strokeColor: Colors.transparent,
        fillColor: Colors.pinkAccent.withOpacity(0.5),
        strokeWidth: 5,
        center: apple.LatLng(_locationData?.latitude ?? initLat,
            _locationData?.longitude ?? initLng),
        radius: 200,
        onTap: () {},
      );
      appleCircles = {appleCircle};
    }
  }
}
