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

  Future addFlight(Flight flight);

  Future deleteFlight(String id);
}

class FlightRepositoryImp extends BaseRepositoryImp<Flight>
    implements FlightRepository {
  @override
  Future<Flight> getById(int id) async {
    return Flight.fromJson(await ApiClient(FLIGHT).get(params: {'id': id}));
  }

  @override
  Future<List<Flight>> getFlights({
    required DateTime fromDate,
    required DateTime toDate,
    Map<String, dynamic>? extraQuery,
  }) async {
    // await fakeDelay;
    // return allFlightsDummy;

    Map<String, dynamic> customQuery = {
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
    };
    customQuery.addAll(extraQuery ?? {});
    return Flight.mapToList(
        await getListFromApi(apiUrl: FLIGHT, customQuery: customQuery));
  }

  @override
  Future addFlight(Flight flight) async {
    await ApiClient(FLIGHT).post(flight.toJson());
  }

  @override
  Future deleteFlight(String id) async {
    await ApiClient(FLIGHT).delete({
      'id': id,
    });
  }
}
