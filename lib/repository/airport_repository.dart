import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

import '../dummy_data.dart';

abstract class AirportRepository extends BaseRepository<Airport> {
  Future<Airport> getById(String code);

  Future<List<Airport>> getAirports();

  Future addAirport(Airport airport);

  Future deleteAirport(Airport airport);
}

class AirportRepositoryImp extends BaseRepositoryImp<Airport>
    implements AirportRepository {
  @override
  Future<Airport> getById(String code) async {
    return airportsDummy.first;
    // return Flight.fromJson(await ApiClient(FLIGHT).get(params: {'id': id}));
  }

  @override
  Future<List<Airport>> getAirports(
    //{
    // required DateTime fromDate,
    // required DateTime toDate,
    // Map<String, dynamic>? extraQuery,
  //}
  ) async {
    // await fakeDelay;
    // return allFlightsDummy;

    // Map<String, dynamic> customQuery = {
    //   'fromDate': fromDate.millisecondsSinceEpoch,
    //   'toDate': toDate.millisecondsSinceEpoch,
    // };
    // customQuery.addAll(extraQuery ?? {});
    // return Airp.mapToList(
    //     await getListFromApi(apiUrl: FLIGHT, customQuery: customQuery));
    return airportsDummy;
  }


  @override
  Future addAirport(Airport airport) async {
    airportsDummy.add(airport);
  }

   @override
  Future deleteAirport(Airport airport) async {
    airportsDummy.remove(airport);
  }
}
