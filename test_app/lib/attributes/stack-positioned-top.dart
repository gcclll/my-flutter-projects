import 'package:flutter/material.dart';

class PositionedTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
//      color: Colors.blue,
      margin: EdgeInsets.all(50.0),
      child: DefaultTabController(
        length: 3,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return Column(
              children: <Widget>[
                _buildTabs(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[

        new Positioned.fill(
          top: null,
          child: new Container(
            height: 20.0,
            color: Colors.red,
          ),
        ),


        new TabBar(
          indicatorColor: Colors.blue,
          tabs: <Widget>[
            Tab(text: "AAAA"),
            Tab(text: 'BBBB'),
            Tab(text: 'CCCC'),
          ],
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
        ),

      ],
    );
  }
}