import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/model/passenger.dart';
import 'package:simplane_client_admin/model/return_ticket_state.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

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

  Future deleteTicket(String id);
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
      'fromDate': fromDate.toIso8601String(),
      'toDate': toDate.toIso8601String(),
    };

    // customQuery.addAll(extraQuery ?? {});

    final allTickets = Ticket.mapToList(
        await getListFromApi(apiUrl: TICKET, customQuery: customQuery));
    if (extraQuery?['filterReturnable'] == true) {
      return allTickets.where((t) => t.returnState is Returnable).toList();
    }

    if (extraQuery?['filterDeparted'] == true) {
      return allTickets
          .where((t) => t.flightDate.compareTo(DateTime.now()) < 0)
          .toList();
    }

    if (extraQuery?['filterDeparted'] == false) {
      return allTickets
          .where((t) => t.flightDate.compareTo(DateTime.now()) > 0)
          .toList();
    }

    return allTickets;
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
      'flightDate': flightDate.toIso8601String(),
      'passenger': passenger.toJson(),
      'ticketClassId': ticketClassId,
      'price': price,
      'bookedTime': bookedTime.toIso8601String(),
      'idUser': UserManager.instance.getUser()!.id,
    }));
  }

  @override
  Future deleteTicket(String id) async {
    await ApiClient(TICKET).delete({
      'id': id,
    });
  }
}
