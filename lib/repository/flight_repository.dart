import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

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
    return Flight.fromJson(await ApiClient(FLIGHT_GET).get(params: {'id': id}));
  }

  @override
  Future<List<Flight>> getFlights({
    required DateTime fromDate,
    required DateTime toDate,
    int page = 1,
    int pageSize = 6,
  }) async {
    Future.delayed(const Duration(seconds: 2));
    return [
      Flight(
          id: 1,
          code: 'VN32134',
          fromAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          toAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          date: DateTime(2022, 4, 12),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 2,
          code: 'VN56456',
          fromAirport: const Airport('HUI', 'Hue', 'Viet Nam'),
          toAirport: const Airport('HAN', 'Ha Noi', 'Viet Nam'),
          date: DateTime(2022, 5, 1),
          duration: 80,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 3,
          code: 'VN76745',
          fromAirport: const Airport('HAN', 'Ha Noi', 'Viet Nam'),
          toAirport: const Airport('HUI', 'Hue', 'Viet Nam'),
          date: DateTime(2022, 6, 10),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
      Flight(
          id: 4,
          code: 'VN86786',
          fromAirport: const Airport('SGN', 'TPHCM', 'Viet Nam'),
          toAirport: const Airport('VDH', 'Dong Hoi', 'Viet Nam'),
          date: DateTime(2022, 6, 11),
          duration: 60,
          seatAmount: const {'E': 80, 'B': 20},
          orderedAmount: const {'E': 56, 'B': 10},
          middleAirports: const [],
          stopDurations: const []),
    ];

    // TODO: chưa có API

    // Map<String, dynamic> customQuery = {
    //   'from': fromDate.toIso8601String(),
    //   'to': toDate.toIso8601String(),
    //   'page': page,
    //   'limit': pageSize,
    // };
    // return Flight.mapToList(
    //     await getListFromApi(apiUrl: FLIGHT_GETS, customQuery: customQuery));
  }
}
