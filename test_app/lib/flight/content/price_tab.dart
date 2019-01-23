import 'package:flutter/material.dart';
import './animated_plane_icon.dart';

class PriceTab extends StatefulWidget {

  final double height;
  const PriceTab({ Key key, this.height }) : super(key : key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {
  final double _initialPlanePaddingBottom = 16.0;
  final double _minPlanePaddingTop = 16.0;

  AnimationController _planeSizeAnimationController;
  Animation _planeSizeAnimation;

  double get _planeTopPadding =>
      widget.height - _initialPlanePaddingBottom - _planeSize;
  double get _planeSize => _planeSizeAnimation.value;

  @override
  void initState() {
   super.initState();
   _initSizeAnimations();
   // 启动动画
   _planeSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _planeSizeAnimationController.dispose();
    super.dispose();
  }

  _initSizeAnimations() {

    _planeSizeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 340),
      vsync: this
    );

    _planeSizeAnimation = Tween<double>(begin: 60.0, end: 36.0)
      .animate(CurvedAnimation(
        parent: _planeSizeAnimationController,
        curve: Curves.easeOut,
      ));
  }

  Widget _buildPlane() {
    return Positioned(
      top: _planeTopPadding,
      child: Column(
        children: <Widget>[
          AnimatedPlaneIcon(animation: _planeSizeAnimation),
        ],
      ),
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