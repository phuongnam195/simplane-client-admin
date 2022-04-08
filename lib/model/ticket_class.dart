import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_class.g.dart';

@JsonSerializable()
class TicketClass extends Equatable {
  final String id;
  final String name;
  final bool canChange;
  final double changeFee;
  final bool canReturn;
  final double returnFee;

  const TicketClass(this.id, this.name, this.canChange, this.changeFee,
      this.canReturn, this.returnFee);

  factory TicketClass.fromJson(Map<String, dynamic> json) =>
      _$TicketClassFromJson(json);

  Map<String, dynamic> toJson() => _$TicketClassToJson(this);

  @override
  List<Object> get props =>
      [id, name, canChange, changeFee, canReturn, returnFee];

  @override
  bool get stringify => true;
}
