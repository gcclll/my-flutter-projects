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

  // 飞机图标距离底部间隔
  final double _initialPlanePaddingBottom = 16.0;

  // 飞机顶部间隔 = 当前 widget 高度 - 飞机底部间距 - 飞机大小
  double get _planeTopPadding =>
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
    _initSizeAnimations();
    // 触发动画
    _planeSizeAnimationController.forward();
  }

  @override
  void dispose() {
    // 直接调用动画控制器的释放方法
    _planeSizeAnimationController.dispose();
    // 任何动画在不使用了就得释放掉
    super.dispose();
  }

  Widget _buildPlane() {
    return Positioned(
      top: _planeTopPadding,
      child: Column(
        children: <Widget>[
          // 用动画 Icon 代替静态的
          AnimatedPlaneIcon(animation: _planeSizeAnimation),
        ],
      ),
    );
  }

  // 初始化动画
  _initSizeAnimations() {
    // 控制器初始化
    _planeSizeAnimationController = AnimationController(
      duration: const Duration(microseconds: 340),
      vsync: this,
    );

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
}
