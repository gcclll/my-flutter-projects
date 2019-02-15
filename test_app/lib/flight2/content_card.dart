import 'package:flutter/material.dart';
import './multicity_input.dart';

// 这里涉及到 有状态控件的创建
// 有状态的控件： 在整个应用使用过程中，会与用户发送交互的控件，比如用户输入

class ContentCard extends StatefulWidget {
  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    // 创建一个卡片容纳用户输入控件
    return new Card(
      elevation: 2.0,
      margin: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        length: 3,
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Column(
              children: <Widget>[
                // 选项卡
                _buildTabBar(),
                // 选项卡内容
                _buildContentContainer(viewportConstraints),
              ],
            );
          },
        ),
      ),
    );
  }

  // 创建选项卡
  Widget _buildTabBar({bool showFirstOption}) {
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          // 设置成 null 那么 Stack 的子控件会被垂直排列，而不是堆叠在一起
          // 因此可以看到这个 Container 在 TabBar 的下面，如果没设置成 null
          // Container 是遮挡在 TabBar 上面的
          top: null,
          child: new Container(
            height: 2.0,
            color: new Color(0xFFEEEEEE),
          ),
        ),
        new TabBar(
          tabs: <Widget>[
            Tab(text: "Flight"),
            Tab(text: "Train"),
            Tab(text: "Bus"),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ],
    );
  }

  // 选项卡内容容器
  Widget _buildContentContainer(BoxConstraints viewportConstraints) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints: new BoxConstraints(
            // 视图最大高度 - tabbar 的高度
            minHeight: viewportConstraints.maxHeight - 48.0
          ),
          // 创建一个高度由 child 实际高度决定的 Widget
          child: new IntrinsicHeight(
            child: _buildMulticityTab(),
          ),
        ),
      ),
    );
  }

  // 多城市选项内容容器，包含多个 input 控件
  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
//        Text("Inputs"), // TODO 添加用户信息输入框
        new MulticityInput(),
        Expanded(child: Container()),
        // 底部增加了一个图标
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.timeline, size: 36.0),
          ),
        ),
      ],
    );
  }
}
