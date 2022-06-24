import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/model/return_ticket_state.dart';

import 'passenger.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket extends Equatable {
  final String id;
  final String flightCode;
  final DateTime flightDate;
  final Passenger passenger;
  final String ticketClassId;
  final double price;
  final DateTime bookedTime;

  const Ticket({
    required this.id,
    required this.flightCode,
    required this.flightDate,
    required this.passenger,
    required this.ticketClassId,
    required this.price,
    required this.bookedTime,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  List<Object?> get props => [
        flightCode,
        flightDate,
        passenger,
        ticketClassId,
        price,
        bookedTime,
      ];

  @override
  bool get stringify => true;

  static List<Ticket> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((data) => Ticket.fromJson(data)).toList();
  }

  ReturnTicketState get returnState {
    final rule = RuleManager.instance.rule!;

    final ticketClasses = rule.ticketClasses;
    final ticketClass =
        ticketClasses.firstWhere((tc) => tc.id == ticketClassId);
    final canReturn = ticketClass.canReturn;

    if (!canReturn) {
      return NotSuitableTicketClass();
    }

    final latestTimeCancelBooking = rule.latestTimeCancelBooking.toInt();
    final now = DateTime.now();
    final diff = flightDate.difference(now);

    if (diff.compareTo(Duration(minutes: latestTimeCancelBooking)) < 0) {
      return OverdueReturning();
    }

    return Returnable(ticketClass.returnFee);
  }
}
