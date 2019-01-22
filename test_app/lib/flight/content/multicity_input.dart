import 'package:flutter/material.dart';

class MulticityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            getPadding("From", Icons.flight_takeoff, color: Colors.red),
            getPadding("To", Icons.flight_land, color: Colors.red),
            getMoreTos(),
            getPadding("Passengers", Icons.person, color: Colors.red),
            getDepartArrivalDate()
          ],
        ),
      ),
    );

  }
}

// 获取更多目的地
Widget getMoreTos() {
  return Row(
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.flight_land, color: Colors.red),
                labelText: "To"
            ),
          ),
        ),
      ),
      Container(
        width: 64.0,
        alignment: Alignment.center,
        child: Icon(Icons.add_circle_outline, color: Colors.grey),
      ),
    ],
  );
}

// 目的地和出发地日期
Widget getDepartArrivalDate() {
  return Row(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Icon(Icons.date_range, color: Colors.red),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: "Departure"),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: "Arrival"),
          ),
        ),
      ),
    ],
  );
}

// 间距
Widget getPadding(String labelText, IconData icon, { color }) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
    child: TextFormField(
      decoration: InputDecoration(
        icon: Icon(icon, color: color),
        labelText: labelText
      ),
    ),
  );
}