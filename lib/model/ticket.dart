import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'passenger.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket extends Equatable {
  final int id;
  final String flightCode;
  final Passenger passenger;
  final String ticketClassId;
  final double price;
  final DateTime orderTime;

  const Ticket(this.id, this.flightCode, this.passenger, this.ticketClassId,
      this.price, this.orderTime);

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  List<Object> get props =>
      [flightCode, passenger, ticketClassId, price, orderTime];

  @override
  bool get stringify => true;
}
