import 'package:flutter/material.dart';

import 'package:wheather_app/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wheather Report',
      home: MainScreen(),
    );
  }
}
