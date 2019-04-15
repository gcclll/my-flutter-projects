import 'dart:io';
import 'dart:convert';

import 'package:test_app/flight2/ticket_page/flight_stop_ticket.dart';
import 'package:test_app/flight2/price_tab/flight_stop.dart';

HttpClient hc = new HttpClient();

Future _get(String path) async {
  var resBody;
  String url = "https://www.gcl666.com/api/flutter/${path}";
  var request = await hc.getUrl(Uri.parse(url));
  var response = await request.close();
  if (response.statusCode == 200) {
    resBody = await response.transform(utf8.decoder).join();
    resBody = await json.decode(resBody);
  } else {
    print("error");
  }

  return resBody;
}

Future<List<FlightStop>> fetchStops() async {
  try {
    var response = await _get('/stops');
    List result = response['data'].toList();
    List<FlightStop> stops = [];

    for (int i = 0; i < result.length; i++) {
      var item = result[i];
      stops.add(new FlightStop(
        item['from'],
        item['to'],
        item['date'],
        item['duration'],
        item['price'],
        item['fromToTime']
      ));
    }

    return stops;
  } catch (e) {
    print(e);
    return [];
  }
}

Future<List<FlightStopTicket>> fetchTicket() async {
  try {
    var response = await _get('/flight');
    List result = response['data'].toList();
    List<FlightStopTicket> tickets = [];

    for (int i = 0; i < result.length; i++) {
      var item = result[i];
      tickets.add(new FlightStopTicket(
          item["from"],
          item["fromShort"],
          item["to"],
          item["toShort"],
          item["flightNumber"],
      ));
    }

    return tickets;
  } catch (e) {
    print(e);
    return [];
  }
}