import 'package:flutter/material.dart';

class AirAsiaBar extends StatelessWidget {

  // final 变量声明时必须初始化，且一旦赋值之后就不能发生改变
  final double height;

  // 声明了一个构造函数，且对 height 进行了初始化
  // 即在创建 `AirAsiaBar` 的时候由调用者去初始化其高度
  const AirAsiaBar({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 将导航条上所有控件放在 Stack 上，让他们有一定的堆叠关系
    return Stack(
      // stack 是个多子节点的控件
      children: <Widget>[
        // 控件容器
        new Container(
          // 组织控件的渲染属性，比如：渐变，动画，颜色等等
          decoration: new BoxDecoration(
            // 渐变特效，从顶至下，渐变色有 colors 指定
             gradient: new LinearGradient(
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
               colors: [Colors.red, const Color(0xFFE64C85)],
             ),
          ),
          // 指定该导航条的高度
          height: height,
        ),
        new AppBar(
          backgroundColor: Colors.transparent,
          // 控制条下面的阴影部分
          elevation: 0.0,
          centerTitle: true,
          title: new Text(
            "AsiaAir",
            style: TextStyle(
              // 外部新增的字体
              fontFamily: 'NothingYouCouldDo',
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}