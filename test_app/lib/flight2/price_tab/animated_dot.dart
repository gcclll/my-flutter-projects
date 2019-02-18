import 'package:flutter/material.dart';

// 修改点 1： -> AnimatedWidget
class AnimatedDot extends AnimatedWidget {

  final Color color;
//  final double mTop;
  static final double size = 24.0;

  AnimatedDot({
    Key key,
    // 修改点 2
    Animation<double> animation,
    @required this.color,
//    this.mTop,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // 修改点 3
    Animation<double> animation = super.listenable;

    return Positioned(
      // 修改点 4
      top: animation.value,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFFDDDDDD),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}