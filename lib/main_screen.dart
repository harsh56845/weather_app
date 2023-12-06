// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:wheather_app/models/weather.dart';
import 'package:wheather_app/services/weather_service.dart';

import 'package:wheather_app/widgets/humid.dart';
// import 'package:wheather_app/widgets/tf.dart';
// import 'package:wheather_app/widgets/wheather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var cityController = TextEditingController();
  final ws = WeatherService();
  bool isLoading = true;
  Weather? _weather;
  var cityName = "delhi";

  void check() {
    if (cityController.text == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Invalid"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Okay"))
          ],
        ),
      );
    } else {
      setState(() {
        cityName = cityController.text;
      });
      get();
      isLoading = true;

      // print(cityName);
    }
  }

  int degree = 23;

  void getLocatio() {}

  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      //   print('Location services are disabled.');
      //   return null;
      // }

      // // Request permission to access location
      // LocationPermission permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   if (permission == LocationPermission.denied) {
      //     print('Location permissions are denied.');
      //     return null;
      //   }
      // }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // List<Placemark> placemarks = await placemarkFromCoordinates(
      //   position.latitude,
      //   position.longitude,
      // );
      // https://api.geoapify.com/v1/geocode/reverse?lat=${lat}&lon=${lon}&apiKey="dbff22d7a40b4e1cb50c60b8fb69821f"
      // print("lon ${position.latitude}");
      // print(position.longitude);

      try {
        final weather =
            await ws.getWeatherByLoc(position.latitude, position.longitude);
        setState(() {
          _weather = weather;
          isLoading = false;
        });
        print(_weather!.windSpeed);
      } catch (e) {
        setState(() {
          isLoading = true;
        });
      }

      return position;
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  void get() async {
    try {
      final weather = await ws.getWeatherByCity(cityName);
      setState(() {
        _weather = weather;
        isLoading = false;
      });
      print(_weather!.windSpeed);
    } catch (e) {
      setState(() {
        isLoading = true;
      });
    }

    // print(_weather!.humidity);
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();

    super.initState();
  }

  // void check() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 3, 237, 245),
            Color.fromARGB(255, 82, 105, 235)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 700,
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: TextField(
                      maxLength: 15,
                      controller: cityController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter City Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 52,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                        onPressed: () {
                          // print(isLoading);

                          check();
                          // getCurrentLocation();
                          // print(isLoading);
                        },
                        icon: const Icon(Icons.search_rounded))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/sun.png',
            ),
            const SizedBox(
              height: 30,
            ),
            if (isLoading == false)
              mainData(context, _weather!)
            else
              CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}

Widget mainData(BuildContext context, Weather weather) {
  return Column(
    children: [
      // if (_weather?.name != null)
      Text(
        weather.city,
        style: const TextStyle(fontSize: 45, color: Colors.white),
      ),
      const SizedBox(
        height: 20,
      ),
      // if (_weather.temp != null)
      Text('${weather.temp}°C',
          style: TextStyle(fontSize: 45, color: Colors.white)),
      const SizedBox(
        height: 30,
      ),
      // if (_weather?.humidity != null)
      Humid(weather.humidity, weather.windSpeed),
    ],
  );
}
