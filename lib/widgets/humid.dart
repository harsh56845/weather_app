// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class Humid extends StatelessWidget {
  var humid;
  var windSpeed;
  Humid(this.humid, this.windSpeed);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ignore: avoid_unnecessary_containers
        Container(
          child: Row(
            children: [
              Image.asset(
                'assets/images/wind.png',
                height: 50,
                width: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    "${windSpeed}km/hr",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "windSpeed",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        // ignore: avoid_unnecessary_containers
        Container(
          child: Row(
            children: [
              Image.asset(
                'assets/images/humid.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  if (humid != null)
                    Text(
                      '$humid%',
                      style: TextStyle(color: Colors.white),
                    ),
                  const Text(
                    'Humidity',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
