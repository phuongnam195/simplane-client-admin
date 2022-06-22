import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/model/passenger.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

import '../dummy_data.dart';

abstract class TicketRepository extends BaseRepository<Ticket> {
  Future<Ticket> getById(int id);

  Future<List<Ticket>> getTickets({
    required DateTime fromDate,
    required DateTime toDate,
    Map<String, dynamic>? extraQuery,
  });

  Future<Ticket> bookTicket({
    required String flightCode,
    required DateTime flightDate,
    required Passenger passenger,
    required String ticketClassId,
    required double price,
    required DateTime bookedTime,
  });
}

class TicketRepositoryImp extends BaseRepositoryImp<Ticket>
    implements TicketRepository {
  @override
  Future<Ticket> getById(int id) async {
    return Ticket.fromJson(await ApiClient(TICKET).get(params: {'id': id}));
  }

  @override
  Future<List<Ticket>> getTickets({
    required DateTime fromDate,
    required DateTime toDate,
    Map<String, dynamic>? extraQuery,
  }) async {
    // await fakeDelay;
    // if (extraQuery == null) {
    //   return allTicketsDummy;
    // } else if (extraQuery['isBooked'] == true) {
    //   return allTicketsDummy.where((e) => e.isBooked).toList();
    // } else if (extraQuery['isBooked'] == false) {
    //   return allTicketsDummy.where((e) => !e.isBooked).toList();
    // } else {
    //   return allTicketsDummy;
    // }

    Map<String, dynamic> customQuery = {
      'fromDate': fromDate.millisecondsSinceEpoch,
      'toDate': toDate.millisecondsSinceEpoch,
    };

    customQuery.addAll(extraQuery ?? {});

    return Ticket.mapToList(
        await getListFromApi(apiUrl: TICKET, customQuery: customQuery));
  }

  @override
  Future<Ticket> bookTicket({
    required String flightCode,
    required DateTime flightDate,
    required Passenger passenger,
    required String ticketClassId,
    required double price,
    required DateTime bookedTime,
  }) async {
    return Ticket.fromJson(await ApiClient(TICKET).post({
      'flightCode': flightCode,
      'flightDate': flightDate,
      'passenger': passenger.toJson(),
      'ticketClassId': ticketClassId,
      'price': price,
      'bookedTime': bookedTime.microsecondsSinceEpoch,
    }));
  }
}
