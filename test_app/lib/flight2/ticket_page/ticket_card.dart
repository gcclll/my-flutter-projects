import 'package:flutter/material.dart';
import './flight_stop_ticket.dart';

class TicketCard extends StatelessWidget {
  final FlightStopTicket stop;

  const TicketCard({Key key, this.stop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(10.0),
      child: Material(
        elevation: 4.0,
        shadowColor: Color(0x30E5E5E5),
        color: Colors.transparent,
        child: ClipPath(
          clipper: TicketClipper(12.0),
          child: Card(
            elevation: 0.0,
            margin: const EdgeInsets.all(2.0),
            child: _buildCardContent(),
          ),
        ),
      ),
    );
  }

  // 生成票卡片上文字的样式
  TextStyle _getTextStyle(double fontSize, FontWeight fontWeight) {
    return new TextStyle(fontSize: fontSize, fontWeight: fontWeight) ;
  }

  // 生成左右两侧的文本控件
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

  // 票信息页面容器
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
              Text(stop.flightNumber, style: flightNumberStyle),
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

class TicketClipper extends CustomClipper<Path> {
  final double radius;

  TicketClipper(this.radius);

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(
      Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: radius)
    );
    path.addOval(
      Rect.fromCircle(center: Offset(size.width, size.height / 2), radius: radius)
    );

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}