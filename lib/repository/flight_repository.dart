import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

import '../dummy_data.dart';

abstract class FlightRepository extends BaseRepository<Flight> {
  Future<Flight> getById(int id);

  Future<List<Flight>> getFlights({
    required DateTime fromDate,
    required DateTime toDate,
    Map<String, dynamic>? extraQuery,
  });
}

class FlightRepositoryImp extends BaseRepositoryImp<Flight>
    implements FlightRepository {
  @override
  Future<Flight> getById(int id) async {
    return Flight.fromJson(await ApiClient(FLIGHT_GET).get(params: {'id': id}));
  }

  @override
  Future<List<Flight>> getFlights({
    required DateTime fromDate,
    required DateTime toDate,
    Map<String, dynamic>? extraQuery,
  }) async {
    await fakeDelay;
    return allFlightsDummy;

    // TODO: chưa có API

    // Map<String, dynamic> customQuery = {
    //   'from': fromDate.toIso8601String(),
    //   'to': toDate.toIso8601String(),
    // };
    // customQuery.addAll(extraQuery ?? {});
    // return Flight.mapToList(
    //     await getListFromApi(apiUrl: FLIGHT_GETS, customQuery: customQuery));
  }
}
