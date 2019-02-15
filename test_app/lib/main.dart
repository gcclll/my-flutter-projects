import "package:flutter/material.dart";
import "flight2/home_page.dart";
//import "./attributes/stack-positioned-top.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flight Search',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
//      home: new PositionedTop(),
    );
  }
}