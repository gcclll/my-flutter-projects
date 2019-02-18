import 'package:flutter/material.dart';
import './flight_stop_ticket.dart';

class TicketCard extends StatelessWidget {
  final FlightStopTicket stop;

  const TicketCard({Key key, this.stop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(2.0),
      child: _buildCardContent(),
    );
  }

  TextStyle _getTextStyle(double fontSize, FontWeight fontWeight) {
    return new TextStyle(fontSize: fontSize, fontWeight: fontWeight) ;
  }

  Widget _getTextWidget(EdgeInsetsGeometry padding, Text text, Text shortText, {
    CrossAxisAlignment crossAxiAlignment = CrossAxisAlignment.start
  }) {
    return Expanded(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: crossAxiAlignment,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: text,
            ),
            shortText,
          ],
        ),
      ),
    );
  }

  Container _buildCardContent() {
    TextStyle airportNameStyle = _getTextStyle(16.0, FontWeight.w600);
    TextStyle airportShortNameStyle = _getTextStyle(36.0, FontWeight.w200);
    TextStyle flightNumberStyle = _getTextStyle(12.0, FontWeight.w500);

    return Container(
      height: 104.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _getTextWidget(
            const EdgeInsets.only(left: 32.0, top: 16.0),
            Text(stop.from, style: airportNameStyle),
            Text(stop.fromShort, style: airportShortNameStyle)
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  Icons.airplanemode_active,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          _getTextWidget(
            const EdgeInsets.only(left: 40.0, top: 16.0),
            Text(stop.to, style: airportNameStyle),
            Text(stop.toShort, style: airportShortNameStyle)
          ),
        ],
      ),
    );
  }
}