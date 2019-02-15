import 'package:flutter/material.dart';

// 飞机动画 Icon

class AnimatedPlaneIcon extends AnimatedWidget {
  AnimatedPlaneIcon({Key key, Animation<double> animation})
    : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {

    // 这里的 listenable 来自 上面的构造函数中调用 super 设置的 animation
    Animation<double> animation = super.listenable;

    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      // 动画值
      size: animation.value,
    );
  }
}