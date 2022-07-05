import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
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
    Map<String, dynamic> customQuery = {
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
    };
    customQuery.addAll(extraQuery ?? {});
    return Flight.mapToList(
        await getListFromApi(apiUrl: FLIGHT, customQuery: customQuery));

    // final maps = await getListFromApi(apiUrl: FLIGHT);

    // List<Flight> result = [];
    // for (int i = 0; i < maps.length; i++) {
    //   Map<String, dynamic> map = maps[i];
    //   var fixMap = map
    //     ..addAll({
    //       'ticketClassPrice': {
    //         'P': 100000.0,
    //         'L': 200000.0,
    //         'C': 300000.0,
    //       }
    //     });
    //   fixMap['fromAirport']['id'] = '$i';
    //   fixMap['toAirport']['id'] = '${i + 100}';
    //   result.add(Flight.fromJson(fixMap));
    // }
    // return result;
  }

  @override
  Future addFlight(Flight flight) async {
    var json = flight.toJson();
    json['fromAirportCode'] = json['fromAirport'].code;
    json['toAirportCode'] = json['toAirport'].code;
    await ApiClient(FLIGHT).post(json);
  }

  @override
  Future deleteFlight(String id) async {
    await ApiClient(FLIGHT + '/' + id).delete({});
  }
}
