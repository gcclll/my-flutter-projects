import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Square'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          color: const Color(0xFF00FF00),
          width: 48.0,
          height: 48.0
        )
      )
    );
  }
}
