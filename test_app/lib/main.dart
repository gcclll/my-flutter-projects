import 'package:flutter/material.dart';
//import './rows/my_row.dart';
import './pages/home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Startup Name Generator',
      home: Home(),
      color: Colors.lightBlue,
      debugShowCheckedModeBanner: false,
      // home: RandomWords(),
    );
  }
}
