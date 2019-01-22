import "package:flutter/material.dart";
import "flight/homepage.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flight Search',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new HomePage(),
    );
  }
}