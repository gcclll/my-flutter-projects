import 'package:flutter/material.dart';

// 自定义按钮组件

class RoundedButton extends StatelessWidget {

  final String text; // 按钮文本
  final bool selected; // 按钮是否被选中
  final GestureTapCallback onTap; // tap 手势回调

  // 构造函数初始化按钮文本，状态和回调，默认非选中
  const RoundedButton({Key key, this.text, this.selected = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 选中白色，非选中透明
    Color backgroundColor = selected ? Colors.white : Colors.transparent;
    // 按钮文字选中红色，非选中白色
    Color textColor = selected ? Colors.red : Colors.white;

    // 按钮可能多个按钮排列在一起，因此用 Expanded 包裹起来
    // 让其能根据布局自适应位置
    return Expanded(
      // 使用 Padding 空间控制间隙，也可以使用 padding 属性，建议使用控件形式
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: new InkWell(
          onTap: onTap,
          child: new Container(
            height: 36.0,
            decoration: new BoxDecoration(
              color: backgroundColor,
              // 按钮白色 1 像素的边框
              border: new Border.all(color: Colors.white, width: 1.0),
              // 按钮圆角
              borderRadius: new BorderRadius.circular(30.0),
            ),
            child: new Center(
              child: new Text(
                text,
                style: new TextStyle(color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
