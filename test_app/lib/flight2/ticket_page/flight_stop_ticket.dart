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

  factory FlightStopTicket.fromJson(Map<String, dynamic> json) {
    return FlightStopTicket(
      json['from'],
      json['fromShort'],
      json['to'],
      json['toShort'],
      json['flightNumber'],
    );
  }
}