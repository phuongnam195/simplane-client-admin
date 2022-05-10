import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'passenger.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket extends Equatable {
  final int id;
  final String code;
  final String flightCode;
  final DateTime flightDate;
  final Passenger? passenger;
  final String ticketClassId;
  final double price;
  final DateTime? bookedTime;

  const Ticket(
      {required this.id,
      required this.code,
      required this.flightCode,
      required this.flightDate,
      required this.passenger,
      required this.ticketClassId,
      required this.price,
      this.bookedTime});

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  List<Object?> get props => [
        code,
        flightCode,
        flightDate,
        passenger,
        ticketClassId,
        price,
        bookedTime
      ];

  @override
  bool get stringify => true;

  static List<Ticket> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((data) => Ticket.fromJson(data)).toList();
  }
}
