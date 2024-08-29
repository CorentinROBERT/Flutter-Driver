import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(
      {required this.startLng,
      required this.startLat,
      required this.endLng,
      required this.endLat});

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey =
      '5b3ce3597851110001cf6248f51e9ccb69df4f519b1f5994b8e9ba39';
  /*
  driving-car
  driving-hgv
  cycling-road
  cycling-mountain
  cycling-electric
  foot-walking
  foot-hiking
  wheelchair
  */
  final String pathParam = 'driving-car'; // Change it if you want
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  Future getData() async {
    var urlQuery =
        '$url$pathParam?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat';
    print(urlQuery);
    http.Response response = await http.get(Uri.parse(urlQuery));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
