import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './flight_stop.dart';

class FlightStopCard extends StatefulWidget {

  final FlightStop flightStop;
  // 线条左边还是右边
  final bool isLeft;
  static const double height = 80.0;
  static const double width = 140.0;

  const FlightStopCard({
    Key key,
    @required this.flightStop,
    @required this.isLeft,
  }) : super(key: key);

  @override
  FlightStopCardState createState() => FlightStopCardState();
}

class FlightStopCardState extends State<FlightStopCard>
  with TickerProviderStateMixin {

  AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: FlightStopCard.height,
      child: new Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          buildDurationText(),
        ],
      ),
    );
  }

  double get maxWidth {
    RenderBox renderBox = context.findRenderObject();
    BoxConstraints constraints = renderBox?.constraints;
    double maxWidth = constraints?.maxWidth ?? 0.0;
    return maxWidth;
  }

  Positioned buildDurationText() {
    return Positioned(
      top: 10.0,
      right: 10.0,
      child: Text(
        widget.flightStop.duration,
        style: new TextStyle(
          fontSize: 10.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned buildAirportNamesText() {

  }

  Positioned buildDateText() {

  }

  Positioned buildPriceText() {

  }

  Positioned buildFromToTimeText() {

  }

  Widget buildLine() {

  }

  Positioned buildCard() {

  }
}



