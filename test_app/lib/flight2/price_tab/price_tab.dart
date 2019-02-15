import 'package:flutter/material.dart';
import './animated_plane_icon.dart';

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

  // 飞机图标距离底部间隔
  final double _initialPlanePaddingBottom = 16.0;
  // 飞机最小顶部距离，决定了飞行的终点位置
  final double _minPlanePaddingTop = 16.0;

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
        children: <Widget>[
          _buildPlane()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 控件状态初始化，动画在这里执行初始化
    _initPlaneSizeAnimations();
    _initPlaneTravelAnimations();
    // 触发动画
    _planeSizeAnimationController.forward();
  }

  @override
  void dispose() {
    // 直接调用动画控制器的释放方法
    _planeSizeAnimationController.dispose();
    _planeTravelController.dispose();
    // 任何动画在不使用了就得释放掉
    super.dispose();
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
}
