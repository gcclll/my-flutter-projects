class Ticket {
  final String from;
  final String fromShort;
  final String to;
  final String toShort;
  final String flightNumber;

  Ticket({
    this.from,
    this.fromShort,
    this.to,
    this.toShort,
    this.flightNumber
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      from: json['from'],
      fromShort: json['fromShort'],
      to: json['to'],
      toShort: json['toShort'],
      flightNumber: json['flightNumber'],
    );
  }
}