import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';

part 'rule.g.dart';

@JsonSerializable()
class Rule extends Equatable {
  final List<TicketClass> ticketClasses;
  final double minFlightDuration; // minute
  final double maxMiddleAirport;
  final double minStopDuration; // minute
  final double maxStopDuration; // minute
  final double latestTimeBooking; // minute
  final double latestTimeCancelBooking; // minute

  const Rule(
      {this.ticketClasses = ticketClassesDummy,
      required this.minFlightDuration,
      required this.maxMiddleAirport,
      required this.minStopDuration,
      required this.maxStopDuration,
      required this.latestTimeBooking,
      required this.latestTimeCancelBooking});

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);

  Map<String, dynamic> toJson() => _$RuleToJson(this);

  @override
  List<Object> get props => [
        ticketClasses,
        minFlightDuration,
        maxMiddleAirport,
        minStopDuration,
        maxStopDuration,
        latestTimeBooking,
        latestTimeCancelBooking
      ];

  @override
  bool get stringify => true;
}
