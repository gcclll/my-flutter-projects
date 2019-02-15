import 'package:flutter/material.dart';

class MulticityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // 比如这里传入的第三个参数其实是一个可选的非命名参数
            // 如果是命名参数就需要这样： color: Colors.red
            _buildTextField(Icons.flight_takeoff, "From"),
            _buildTextField(Icons.flight_land, "To"),
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildTextField(
                    Icons.flight_land,
                    "To",
                    padding: const EdgeInsets.only(bottom: 8.0),
                  ),
                ),
                Container(
                  width: 64.0,
                  alignment: Alignment.center,
                  child: Icon(Icons.add_circle_outline, color: Colors.grey),
                ),
              ],
            ),
            _buildTextField(Icons.person, "Passengers"),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.date_range, color: Colors.red),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Departure"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Arrival"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 有序的可选非命名参数 color，非命名表示调用的时候不需要传入参数名称
  Widget _buildTextField(IconData icon, String text, {
    Color color = Colors.red,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
  }) {
    return Padding(
      padding: padding,
      child: TextFormField(
        decoration: InputDecoration(
          // 可选命名参数需要使用 color: color 传递
          icon: Icon(icon, color: color),
          labelText: text,
        ),
      ),
    );
  }
}