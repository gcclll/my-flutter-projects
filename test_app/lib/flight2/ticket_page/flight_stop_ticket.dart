import 'package:flutter/material.dart';

class FlightStopTicket {
  String from; // 出发点
  String fromShort; // 出发地简称
  String to; // 目的地
  String toShort; // 目的地简称
  String flightNumber; // 航班号

  FlightStopTicket(
    this.from,
    this.fromShort,
    this.to,
    this.toShort,
    this.flightNumber
  );
}