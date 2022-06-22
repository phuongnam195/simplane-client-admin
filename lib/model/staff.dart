import 'package:equatable/equatable.dart';
import 'package:simplane_client_admin/model/user.dart';

class Staff extends Equatable {
  final User user;
  final double totalTicket;
  final double totalRevenue;

  const Staff(this.user, this.totalTicket, this.totalRevenue);

  @override
  List<Object> get props => [user, totalTicket, totalRevenue];

  @override
  bool get stringify => true;
}
