import 'package:flutter/material.dart';
import './animated_plane_icon.dart';

class PriceTab extends StatefulWidget {

  final double height;
  const PriceTab({ Key key, this.height }) : super(key : key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {
  final double _initialPlanePaddingBottom = 32.0;
  final double _minPlanePaddingTop = 16.0;

  // 飞机大小动画和控制器
  AnimationController _planeSizeAnimationController;
  Animation _planeSizeAnimation;

  // 飞机飞行动画和控制器
  AnimationController _planeTravelController;
  Animation _planeTravelAnimation;

  // 飞机顶部间隔，需要根据飞机自身的动画来发生改变
  double get _planeTopPadding =>
    _minPlanePaddingTop +
        (1 - _planeTravelAnimation.value) * _maxPlaneTopPadding;
  // 飞机最大顶部间隔，即飞机一开始的位置
  // = 当前Widget的高度 - 飞机初始底部的距离 - 飞机的大小；
  double get _maxPlaneTopPadding =>
    widget.height - _initialPlanePaddingBottom - _planeSize;
  // 飞机的大小
  double get _planeSize => _planeSizeAnimation.value;

  @override
  void initState() {
   super.initState();
   _initPlaneSizeAnimations();
   _initPlaneTravelAnimations();
   // 启动动画
   _planeSizeAnimationController.forward();
//   _planeTravelController.forward();
  }

  @override
  void dispose() {
    _planeSizeAnimationController.dispose();
    _planeTravelController.dispose();
    super.dispose();
  }

  // 初始化飞行动画
  _initPlaneTravelAnimations() {

    _planeTravelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _planeTravelAnimation = CurvedAnimation(
      parent: _planeTravelController,
      // 快出慢进
      curve: Curves.fastOutSlowIn
    );
  }

  // 初始化Size动画
  _initPlaneSizeAnimations() {

    _planeSizeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 340),
      vsync: this
    )..addStatusListener((status) {
      // 动画结束，衔接飞机飞行动画
      if (status == AnimationStatus.completed) {
       Future.delayed(
         Duration(milliseconds: 500),
         () => _planeTravelController.forward()
       );
      }
    });

    _planeSizeAnimation = Tween<double>(begin: 60.0, end: 36.0)
      .animate(CurvedAnimation(
        parent: _planeSizeAnimationController,
        curve: Curves.easeOut,
      ));
  }

  Widget _buildPlane() {
    return AnimatedBuilder(
      animation: _planeTravelAnimation,
      child: Column(
        children: <Widget>[
          AnimatedPlaneIcon(animation: _planeSizeAnimation),
          Container(
            width: 2.0,
            height: 240.0,
            color: Color.fromARGB(255, 200, 200, 200),
          ),
        ],
      ),
      builder: (context, child) => Positioned(
        top: _planeTopPadding,
        child: child,
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