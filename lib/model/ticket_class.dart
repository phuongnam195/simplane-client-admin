import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplane_client_admin/generated/l10n.dart';

part 'ticket_class.g.dart';

@JsonSerializable()
class TicketClass extends Equatable {
  final String id;
  final String enName;
  final String viName;
  final bool canChange;
  final double changeFee;
  final bool canReturn;
  final double returnFee;

  const TicketClass(this.id, this.enName, this.viName, this.canChange,
      this.changeFee, this.canReturn, this.returnFee);

  factory TicketClass.fromJson(Map<String, dynamic> json) =>
      _$TicketClassFromJson(json);

  Map<String, dynamic> toJson() => _$TicketClassToJson(this);

  String get name => S.current.languageCode == 'en' ? enName : viName;

  @override
  List<Object> get props =>
      [id, enName, viName, canChange, changeFee, canReturn, returnFee];

  @override
  bool get stringify => true;

  static List<TicketClass> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((data) => TicketClass.fromJson(data)).toList();
  }
}
