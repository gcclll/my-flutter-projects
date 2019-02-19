import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/fetch_apis.dart';
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

  Future<List<FlightStopTicket>> _post;
  List<FlightStopTicket> stops;

  @override
  void initState() {
    super.initState();
    _post = fetchTicket();
  }

  void _initAnimation() {
    initCardAnimations();
    _cardEntranceAnimationController.forward();
  }

  @override
  void dispose() {
    _cardEntranceAnimationController.dispose();
    super.dispose();
  }

  FutureBuilder _buildFutureTicket() {
    return FutureBuilder<List<FlightStopTicket>>(
      future: _post,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          stops = snapshot.data;
          _initAnimation();
          return new Column(
            children: _buildTicket().toList(),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
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
              child: _buildFutureTicket(),
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

      double start = (index % 4) * 0.1;
      double duration = 0.6;
      double end = duration + start;
      return new Tween<double>(
        begin: 800.0,
        end: 0.0
      ).animate(
        new CurvedAnimation(
          parent: _cardEntranceAnimationController,
//          curve: Curves.easeIn,
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