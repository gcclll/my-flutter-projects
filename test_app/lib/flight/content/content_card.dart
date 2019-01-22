import 'package:flutter/material.dart';
import './multicity_input.dart';
import './price_tab.dart';

class ContentCard extends StatefulWidget {
  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {

  bool showInput = true;

  @override
  Widget build(BuildContext context) {

    return new Card(
     elevation: 4.0,
     margin: const EdgeInsets.all(8.0) ,
      child: DefaultTabController(
        length: 3,
        child: new LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return Column(
                children: <Widget>[
                  _buildTabVar(),
                  _buildContentContainer(viewportConstraints),
                ],
              );
            }
        ),
      ),
    );
  }

  Widget _buildTabVar({ bool showFirstOption }) {
    return Stack(
      children: <Widget>[
        new Positioned.fill(
          top: null,
          child: new Container(
            height: 2.0,
            color: new Color(0xFFEEEEEE),
          )
        ),
        new TabBar(
          tabs: [
            Tab(text: "Flight"),
            Tab(text: "Train"),
            Tab(text: "Bus"),
          ],
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        )
      ],
    );
  }

  Widget _buildContentContainer(BoxConstraints viewportConstaints) {
    return Expanded(
      child: SingleChildScrollView(
        child: new ConstrainedBox(
          constraints:  new BoxConstraints(
            minHeight: viewportConstaints.maxHeight - 48.0
          ),
          child: new IntrinsicHeight(
            child: showInput
                ? _buildMulticityTab()
                : PriceTab(
                    height: viewportConstaints.maxHeight - 48.0
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildMulticityTab() {
    return Column(
      children: <Widget>[
        MulticityInput(),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
          child: FloatingActionButton(
            onPressed: () => setState(() => showInput = false),
            child: Icon(Icons.timeline, size: 36.0),
          ),
        ),
      ],
    );
  }
}