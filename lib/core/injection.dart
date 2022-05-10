import 'package:get/get.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';

void configureDependencies() async {
  Get.lazyPut<UserRepository>(() => UserRepositoryImp());
  Get.lazyPut<FlightRepository>(() => FlightRepositoryImp());
}
