import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 45.0),
      alignment: Alignment.center,
      color: Colors.deepOrange,
      child: Column(
        children: <Widget>[
          Row(
            children: getRow([
                'Pon',
                'Dom'
            ])
          )
        ]
      )
    );
  }
}

List<Widget> getRow(List<String> names) {
  List<Widget> rows = [];
  for (int i = 0; i < names.length; i++) {
    rows.add(
      Expanded(
        child: getRowItem(names[i])
      )
    );
  }

  return rows;
}

Widget getRowItem(String name) {

  return Text(
    name,
    textDirection: TextDirection.ltr,
    style: TextStyle(
      decoration: TextDecoration.none,
      fontSize: 35.0,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w700,
      color: Colors.white
  ));
}

class FlightImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AssetImage assetImg = AssetImage('images/flight.png');
    Image image = Image(image: assetImg);
    return Container(child: image);
  }
}
