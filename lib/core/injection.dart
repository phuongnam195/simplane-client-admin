import 'package:get/get.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/repository/report_repository.dart';
import 'package:simplane_client_admin/repository/ticket_repository.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';

void configureDependencies() async {
  Get.lazyPut<UserRepository>(() => UserRepositoryImp(), fenix: true);
  Get.lazyPut<FlightRepository>(() => FlightRepositoryImp(), fenix: true);
  Get.lazyPut<TicketRepository>(() => TicketRepositoryImp(), fenix: true);
  Get.lazyPut<ReportRepository>(() => ReportRepositoryImp(), fenix: true);
}
