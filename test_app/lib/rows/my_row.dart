import 'package:flutter/material.dart';

class MyRow extends StatelessWidget {

  _getBottomItem(IconData icon, String text) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 16.0, color: Colors.grey),
            Padding(padding: EdgeInsets.only(left: 5.0)),
            Text(
              text,
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A Row Example')
      ),
      body: Container(
        child: Card(
          child: FlatButton(
            onPressed: () { print('Button Clicked.'); },
            child: Padding(
              padding: EdgeInsets.only(left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Text(
                      'This is a description',
                      style: TextStyle(
                        color: const Color.fromRGBO(94, 59, 20, 1.0),
                        fontSize: 14.0
                      ),
                      // 超过三行，显示省略号
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis
                    ),
                    margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                    alignment: Alignment.topLeft
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _getBottomItem(Icons.star, '1000'),
                      _getBottomItem(Icons.link, '1000'),
                      _getBottomItem(Icons.subject, '1000'),
                    ]
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
