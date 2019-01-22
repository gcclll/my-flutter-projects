import 'package:flutter/material.dart';
//import './animated_plane_icon.dart';

class PriceTab extends StatefulWidget {

  final double height;
  const PriceTab({ Key key, this.height }) : super(key : key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {
  final double _initialPlanePaddingBottom = 16.0;
  final double _minPlanePaddingTop = 16.0;

  double get _planeTopPadding =>
      widget.height - _initialPlanePaddingBottom - _planeSize;
  double get _planeSize => 60.0;

  Widget _buildPlane() {
    return Positioned(
      top: _planeTopPadding,
      child: Column(
        children: <Widget>[
          _buildPlaneIcon()
        ],
      ),
    );
  }

  Widget _buildPlaneIcon() {
    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      size: _planeSize,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildPlane()
        ],
      )
    );
  }
}