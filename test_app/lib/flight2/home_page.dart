import 'package:flutter/material.dart';
import './air_asia_bar.dart';
import './rounded_button.dart';
import './content_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 导航条
          AirAsiaBar(height: 210.0),
          Positioned.fill(
            child: Padding(
              // 查询上下文的 padding top
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 40.0
              ),
              child: new Column(
                children: <Widget>[
                  _buildButtonRow(),
                  Expanded(
                    child: ContentCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // 创建一个包含按钮的行空间(Row)
  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // 行内的控件会在水平位置并排排列
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "ONE WAY"),
          new RoundedButton(text: "ROUND"),
          new RoundedButton(text: "MULTICITY", selected: true),
        ],
      ),
    );
  }
}
