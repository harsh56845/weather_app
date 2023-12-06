// import 'package:ht';
// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wheather_app/models/weather.dart';
//

class WeatherService {
  String apiKey = "d9af1460d74b20217fcd7237b55cdf40";
  static const String baseUrl =
      "https://api.openweathermap.org/data/2.5/weather";

  Future<Weather> getWeatherByCity(String cityName) async {
    var url = "$baseUrl?q=$cityName&appid=$apiKey&units=metric";
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return Weather.fromJson(data);
    } else {
      throw Exception("Filed to load");
    }
  }

  Future<Weather> getWeatherByLoc(var lat, var lon) async {
    String lati = lat.toString();
    String loni = lon.toString();

    print(lati);
    print(lon);

    var url = "$baseUrl?lat=$lati&lon=$loni&appid=$apiKey&units=metric";
    Response response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return Weather.fromJson(data);
    } else {
      throw Exception("Filed to load");
    }
  }
}
