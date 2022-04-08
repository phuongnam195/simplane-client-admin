import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/network/api_path.dart';

abstract class FlightRepository extends BaseRepository<Flight> {
  Future<Flight> getById(int id);
  Future<List<Flight>> getFlights({
    required DateTime fromDate,
    required DateTime toDate,
    int page = 1,
    int pageSize = 6,
  });
}

class FlightRepositoryImp extends BaseRepositoryImp<Flight>
    implements FlightRepository {
  @override
  Future<Flight> getById(int id) async {
    return Flight.fromJson(
        await getFromApi(apiUrl: FLIGHT_GET, customQuery: {'id': id}));
  }

  @override
  Future<List<Flight>> getFlights({
    required DateTime fromDate,
    required DateTime toDate,
    int page = 1,
    int pageSize = 6,
  }) async {
    Map<String, dynamic> customQuery = {
      'from': fromDate.toIso8601String(),
      'to': toDate.toIso8601String(),
      'page': page,
      'limit': pageSize,
    };
    return Flight.mapToList(
        await getListFromApi(apiUrl: FLIGHT_GETS, customQuery: customQuery));
  }
}
