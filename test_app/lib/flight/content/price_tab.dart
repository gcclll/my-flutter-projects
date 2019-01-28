import 'package:flutter/material.dart';
import './animated_plane_icon.dart';
import './animated_dot.dart';

class PriceTab extends StatefulWidget {

  final double height;
  const PriceTab({ Key key, this.height }) : super(key : key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {

  final List<int> _flightStops = [1, 2, 3, 4];
  final double _cardHeight = 80.0;

  final double _initialPlanePaddingBottom = 32.0;
  final double _minPlanePaddingTop = 16.0;

  // 点动画
  AnimationController _dotsAnimationController;
  List<Animation<double>> _dotPositions = [];

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
   _initDotAnimationController();
   _initDotAnimations();
   // 启动动画
   _planeSizeAnimationController.forward();
//   _planeTravelController.forward();
  }

  @override
  void dispose() {
    _planeSizeAnimationController.dispose();
    _planeTravelController.dispose();
    _dotsAnimationController.dispose();
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
       Future.delayed(
         Duration(milliseconds: 700),
         () => _dotsAnimationController.forward(),
       );
      }
    });

    _planeSizeAnimation = Tween<double>(begin: 60.0, end: 36.0)
      .animate(CurvedAnimation(
        parent: _planeSizeAnimationController,
        curve: Curves.easeOut,
      ));
  }

  // 初始化点动画和控制器
  void _initDotAnimations() {
    // 两点之间动画间隔
    final double slideDurationInterval = 0.4;
    // 下一个点动画的启动延时
    final double slideDelayInterval = 0.2;
    // 线条上每个点的高度
    final double _cardH = 0.8 * _cardHeight;
    // 起始位置为屏幕底部
    double startingMarginTop = widget.height;
    // 与顶部的最小间隔，飞机顶部距离+飞机大小+加一半的card高度
    double minMarginTop =
        _minPlanePaddingTop + _planeSize + 0.5 * _cardH;

    for (int i = 0; i < _flightStops.length; i++) {
      // 开始时间
      final start = slideDelayInterval * i;
      // 结束时间 = 开始时间 + 动画时长
      final end = start + slideDurationInterval;

      double finalMarginTop = minMarginTop + i * _cardH;

      Animation<double> animation = new Tween(
        begin: startingMarginTop,
        end: finalMarginTop,
      ).animate(
        new CurvedAnimation(
          parent: _dotsAnimationController,
          curve: new Interval(start, end, curve: Curves.easeOut)
        ),
      );

      // 将动画保存到点动画数组中，里面包含了每个点动画的属性和状态值
      _dotPositions.add(animation);
    }
  }
  
  void _initDotAnimationController() {
    _dotsAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500)
    );
  }

  // 根据索引拿到动画点
  Widget _mapFlightStopToDot(stop) {
    int index = _flightStops.indexOf(stop);
    bool isStartOrEnd = index == 0 || index == _flightStops.length - 1;
    Color color = isStartOrEnd ? Colors.red : Colors.green;
    return AnimatedDot(
      animation: _dotPositions[index],
      color: color
    );
  }

  Widget _buildPlane() {
    return AnimatedBuilder(
      animation: _planeTravelAnimation,
      child: Column(
        children: <Widget>[
          AnimatedPlaneIcon(animation: _planeSizeAnimation),
          Container(
            width: 2.0,
            // 高度根据点的个数和其间距决定
            height: _flightStops.length * _cardHeight * 0.8,
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
        ]..addAll(_flightStops.map(_mapFlightStopToDot)),
      )
    );
  }
}