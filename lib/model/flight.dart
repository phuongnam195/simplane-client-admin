import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'airport.dart';

part 'flight.g.dart';

@JsonSerializable()
class Flight extends Equatable {
  final int id;
  final String flightCode;
  final Airport fromAirport;
  final Airport toAirport;
  final DateTime start;
  final int duration;
  final Map<String, dynamic>
      seatAmount; // key = {'ticketClass', 'available', 'ordered'}

  const Flight(this.id, this.flightCode, this.fromAirport, this.toAirport,
      this.start, this.duration, this.seatAmount);

  factory Flight.fromJson(Map<String, dynamic> json) => _$FlightFromJson(json);

  Map<String, dynamic> toJson() => _$FlightToJson(this);

  @override
  List<Object> get props =>
      [id, flightCode, fromAirport, toAirport, start, duration, seatAmount];

  @override
  bool get stringify => true;

  static List<Flight> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((data) => Flight.fromJson(data)).toList();
  }
}
