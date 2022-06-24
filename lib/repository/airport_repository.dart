import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

import '../dummy_data.dart';

abstract class AirportRepository extends BaseRepository<Airport> {
  Future<Airport> getByCode(String code);

  Future<List<Airport>> getAirports();

  Future addAirport(Airport airport);

  Future updateAirport(Airport airport);

  Future deleteAirport(Airport airport);
}

class AirportRepositoryImp extends BaseRepositoryImp<Airport>
    implements AirportRepository {
  @override
  Future<Airport> getByCode(String code) async {
    return Airport.fromJson(
        await ApiClient(AIRPORT).get(params: {'code': code}));

    // return airportsDummy.first;
  }

  @override
  Future<List<Airport>> getAirports() async {
    final maps = await getListFromApi(apiUrl: LIST_AIRPORT);
    return Airport.mapToList(maps);

    // return airportsDummy;
  }

  @override
  Future addAirport(Airport airport) async {
    await ApiClient(AIRPORT).post(airport.toJson());

    // airportsDummy.add(airport);
  }

  @override
  Future updateAirport(Airport airport) async {
    await ApiClient(AIRPORT).post(airport.toJson());

    // int i = airportsDummy.indexWhere((e) => e.id == airport.id);
    // airportsDummy[i] = airport;
  }

  @override
  Future deleteAirport(Airport airport) async {
    await ApiClient(AIRPORT + '?code=${airport.code}').delete({});

    // airportsDummy.remove(airport);
  }
}
