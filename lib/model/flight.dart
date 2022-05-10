import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'airport.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight extends Equatable {
  final int id;
  final String code;
  final Airport fromAirport;
  final Airport toAirport;
  final DateTime date;
  final int duration;
  final Map<String, int> seatAmount; // key = ticketClassId, value: quantity
  final Map<String, int> orderedAmount; // key = ticketClassId, value: quantity
  final List<Airport> middleAirports;
  final List<int> stopDurations;

  const Flight(
      {required this.id,
      required this.code,
      required this.fromAirport,
      required this.toAirport,
      required this.date,
      required this.duration,
      required this.seatAmount,
      required this.orderedAmount,
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
        date,
        duration,
        seatAmount,
        orderedAmount,
        middleAirports,
        stopDurations
      ];

  @override
  bool get stringify => true;

  static List<Flight> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((data) => Flight.fromJson(data)).toList();
  }
}
