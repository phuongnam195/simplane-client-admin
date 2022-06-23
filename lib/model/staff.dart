import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:simplane_client_admin/model/user.dart';

part 'staff.g.dart';

@JsonSerializable()
class Staff extends Equatable {
  final User user;
  final double totalTicket;
  final double totalRevenue;

  const Staff(this.user, this.totalTicket, this.totalRevenue);

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  Map<String, dynamic> toJson() => _$StaffToJson(this);

  static List<Staff> mapToList(List<dynamic>? maps) {
    if (maps == null || maps.isEmpty) {
      return [];
    }
    return maps.map((data) => Staff.fromJson(data)).toList();
  }

  @override
  List<Object> get props => [user, totalTicket, totalRevenue];

  @override
  bool get stringify => true;
}
