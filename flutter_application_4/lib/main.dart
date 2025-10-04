import 'package:flutter/material.dart';
import 'screen_first/fragment1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа',
      home: Fragment1(),
    );
  }
}
