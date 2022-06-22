import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'airport.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight extends Equatable {
  final String id;
  final String code; // not unique (different `datetime` may have same `code`)
  final Airport fromAirport;
  final Airport toAirport;
  final DateTime dateTime;
  final double duration;
  final Map<String, double>
      ticketClassPrice; // prices of ticket classes, key = ticketClassId, value: price
  final Map<String, double>
      seatAmount; // total seat, key = ticketClassId, value: quantity
  final Map<String, double>
      bookedAmount; // booked seat, key = ticketClassId, value: quantity
  final List<Airport> middleAirports;
  final List<double> stopDurations; // milisecond

  const Flight(
      {required this.id,
      required this.code,
      required this.fromAirport,
      required this.toAirport,
      required this.dateTime,
      required this.duration,
      required this.ticketClassPrice,
      required this.seatAmount,
      required this.bookedAmount,
      required this.middleAirports,
      required this.stopDurations});

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);

  @override
  List<Object> get props => [
        id,
        code,
        fromAirport,
        toAirport,
        dateTime,
        duration,
        ticketClassPrice,
        seatAmount,
        bookedAmount,
        middleAirports,
        stopDurations
      ];

  @override
  bool get stringify => true;

  static List<Flight> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }

    // return maps.map((data) => Flight.fromJson(data)).toList();

    return maps.map((data) {
      Map<String, dynamic> json = data;
      json['ticketClassPrice'] = {
        'P': 100000.0,
        'L': 200000.0,
        'C': 300000.0,
      };
      return Flight.fromJson(json);
    }).toList();
  }
}
