import 'dart:async';

import 'package:flutter/material.dart';
import '../fade_route.dart';
import './animated_plane_icon.dart';
import './animated_dot.dart';
import './flight_stop.dart';
import './flight_stop_card.dart';
import '../ticket_page/tickets_page.dart';

class PriceTab extends StatefulWidget {

  final double height;

  const PriceTab({Key key, this.height}) : super(key: key);

  @override
  _PriceTabState createState() => _PriceTabState();
}

class _PriceTabState extends State<PriceTab> with TickerProviderStateMixin {

  // 动画控制器和动画状态
  AnimationController _planeSizeAnimationController;
  Animation _planeSizeAnimation;
  AnimationController _planeTravelController;
  Animation _planeTravelAnimation;
  // 点动画
  AnimationController _dotsAnimationController;
  // 确认按钮
  AnimationController _fabAnimationController;
  Animation _fabAnimation;

  // 飞机图标距离底部间隔
  final double _initialPlanePaddingBottom = 16.0;
  // 飞机最小顶部距离，决定了飞行的终点位置
  final double _minPlanePaddingTop = 16.0;


  // flight stop card
  final List<FlightStop> _flightStops = [
    FlightStop("JFK", "ORY", "JUN 05", "6h 25m", "\$851", "9:26 am - 3:43 pm"),
    FlightStop("MRG", "FTB", "JUN 20", "6h 25m", "\$532", "9:26 am - 3:43 pm"),
    FlightStop("ERT", "TVS", "JUN 20", "6h 25m", "\$718", "9:26 am - 3:43 pm"),
    FlightStop("KKR", "RTY", "JUN 20", "6h 25m", "\$663", "9:26 am - 3:43 pm"),
  ];
  final List<GlobalKey<FlightStopCardState>> _stopKeys = [];
  List<Animation<double>> _dotPositions = [];

  // 飞机顶部间隔 = 当前 widget 高度 - 飞机底部间距 - 飞机大小
  // 这里增加飞行动画之后，值需要根据动画状态发生改变
  double get _planeTopPadding =>
      _minPlanePaddingTop +
          (1 - _planeTravelAnimation.value) * _maxPlaneTopPadding;

  // 飞机顶部最大距离，即起始位置
  double get _maxPlaneTopPadding =>
    widget.height - _initialPlanePaddingBottom - _planeSize;

  // 飞机大小，有动画之后，实际大小为动画当前 Tick 的实时值
  // Animation 里面保存了动画相关的状态值
  double get _planeSize => _planeSizeAnimation.value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        // 将里面的控件都居中排布
        alignment: Alignment.center,
        children: <Widget>[_buildPlane()]
          ..addAll(_flightStops.map(_buildStopCard))
          ..addAll(_flightStops.map(_mapFlightStopToDot))
          ..add(_buildFab()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 控件状态初始化，动画在这里执行初始化
    _initPlaneSizeAnimations();
    _initPlaneTravelAnimations();
    _initDotAnimationController();
    _initDotAnimations();
    _flightStops.forEach((stop) =>
      _stopKeys.add(new GlobalKey<FlightStopCardState>())
    );
    _initFabAnimationController();
    // 触发动画
    _planeSizeAnimationController.forward();
  }

  @override
  void dispose() {
    // 直接调用动画控制器的释放方法
    _planeSizeAnimationController.dispose();
    _planeTravelController.dispose();
    _dotsAnimationController.dispose();
    _fabAnimationController.dispose();
    // 任何动画在不使用了就得释放掉
    super.dispose();
  }

  Widget _buildFab() {
    return Positioned(
      bottom: 16.0,
      child: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            FadeRoute(builder: (context) => TicketsPage())
          ),
          child: Icon(Icons.check, size: 36.0),
        ),
      ),
    );
  }

  Widget _buildStopCard(FlightStop stop) {
    int index = _flightStops.indexOf(stop);
    double topMargin = _dotPositions[index].value -
      0.5 * (FlightStopCard.height - AnimatedDot.size);
    bool isLeft = index.isOdd;

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: topMargin),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isLeft ? Container() : Expanded(child: Container()),
            Expanded(
              child: FlightStopCard(
                key: _stopKeys[index],
                flightStop: stop,
                isLeft: isLeft,
              ),
            ),
            !isLeft ? Container() : Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  // 返回带动画的空间
  Widget _buildPlane() {
    return AnimatedBuilder(
      animation: _planeTravelAnimation,
      child: Column(
        children: <Widget>[
          // 用动画 Icon 代替静态的
          AnimatedPlaneIcon(animation: _planeSizeAnimation),
          // 在飞机尾部增加一个垂直线条
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

  Widget _mapFlightStopToDot(stop) {
    int index = _flightStops.indexOf(stop);
    bool isStartOrEnd = index == 0 || index == _flightStops.length - 1;

    Color color = isStartOrEnd ? Colors.red : Colors.green;

    return AnimatedDot(
      animation: _dotPositions[index],
      color: color,
    );
  }

  Future _animateFlightStopCards() async {
    return Future.forEach(_stopKeys, (GlobalKey<FlightStopCardState> stopKey) {
      return new Future.delayed(Duration(milliseconds: 250), () {
        // 通过 key 去获取状态启动动画
        stopKey.currentState.runAnimation();
      });
    });
  }

  _initDotAnimations() {

    // 每个点的动画时长
    final double slideDurationInterval = 0.4;
    // 每个点的动画间隔
    final double slideDelayInterval = 0.2;
    final double height = 0.8 * 80;
    // 起始位置
    double startingMarginTop = widget.height;
    double minMarginTop =
        _minPlanePaddingTop + _planeSize + 0.5 * height;

    for (int i = 0; i < _flightStops.length; i++) {
      // 每个点开始动画的时间
      final start = slideDelayInterval * i;
      // 每个动画结束时间
      final end = start + slideDurationInterval;

      double finalMarginTop = minMarginTop + i * height - 20.0;

      Animation<double> animation = new Tween(
        begin: startingMarginTop,
        end: finalMarginTop
      ).animate(
        new CurvedAnimation(
          parent: _dotsAnimationController,
          curve: new Interval(start, end, curve: Curves.easeOut),
        ),
      );

      _dotPositions.add(animation);
    }
  }

  _initDotAnimationController() {
    _dotsAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animateFlightStopCards().then((_) => _animateFab());
      }
    });
  }


  // 初始化动画
  _initPlaneSizeAnimations() {
    // 控制器初始化
    _planeSizeAnimationController = AnimationController(
      duration: const Duration(microseconds: 340),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 飞机大小动画结束之后启动飞行动画
        Future.delayed(
          Duration(microseconds: 500),
          () => _planeTravelController.forward(),
        );

        Future.delayed(Duration(milliseconds: 700), () {
          _dotsAnimationController.forward();
        });
      }
    });

    // 动画状态初始化
    _planeSizeAnimation = Tween<double>(
      // 动画起始和初始值
      begin: 60.0,
      end: 36.0,
    ).animate(
      CurvedAnimation(
        parent: _planeSizeAnimationController, curve: Curves.easeOut
      )
    );
  }

  _initPlaneTravelAnimations() {
    _planeTravelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _planeTravelAnimation = CurvedAnimation(
      parent: _planeTravelController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _initFabAnimationController() {
    _fabAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );

    _fabAnimation = new CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeOut
    );
  }

  _animateFab() {
    _fabAnimationController.forward();
  }
}
