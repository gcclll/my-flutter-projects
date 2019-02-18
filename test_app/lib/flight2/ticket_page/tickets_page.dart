import 'package:flutter/material.dart';
import './flight_stop_ticket.dart';
import './ticket_card.dart';
import '../air_asia_bar.dart';

class TicketsPage extends StatefulWidget {

  @override
  _TicketsPageState createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage>
  with TickerProviderStateMixin {

  AnimationController _cardEntranceAnimationController;
  List<Animation> _ticketAnimations;
  Animation _fabAnimation;

  List<FlightStopTicket> stops = [
    new FlightStopTicket("Sahara", "SHE", "Macao", "MAC", "SE2341"),
    new FlightStopTicket("Macao", "MAC", "Cape Verde", "CAP", "KU2342"),
    new FlightStopTicket("Cape Verde", "CAP", "Ireland", "IRE", "KR3452"),
    new FlightStopTicket("Ireland", "IRE", "Sahara", "SHE", "MR4321"),
  ];

  @override
  void initState() {
    super.initState();
    initCardAnimations();
    _cardEntranceAnimationController.forward();
  }

  @override
  void dispose() {
    _cardEntranceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          AirAsiaBar(height: 180.0),
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 64.0,
            child: SingleChildScrollView(
              child: new Column(
                children: _buildTicket().toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void initCardAnimations() {
    _cardEntranceAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );

    _ticketAnimations = stops.map((stop) {
      int index = stops.indexOf(stop);

      double start = index * 0.1;
      double duration = 0.6;
      double end = duration + start;
      return new Tween<double>(
        begin: 800.0,
        end: 0.0
      ).animate(
        new CurvedAnimation(
          parent: _cardEntranceAnimationController,
          curve: new Interval(start, end, curve: Curves.decelerate)
        )
      );
    }).toList();

    _fabAnimation = new CurvedAnimation(
      parent: _cardEntranceAnimationController,
      curve: Interval(0.7, 1.0, curve: Curves.decelerate)
    );
  }

  Iterable<Widget> _buildTicket() {
    return stops.map((stop) {
      int index = stops.indexOf(stop);
      return AnimatedBuilder(
        animation: _cardEntranceAnimationController,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: TicketCard(stop: stop),
        ),
        builder: (context, child) => new Transform.translate(
          offset: Offset(0.0, _ticketAnimations[index].value),
          child: child,
        ),
      );
    });
  }

  _buildFab() {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).pop(),
      child: new Icon(Icons.fingerprint),
    );
  }
}