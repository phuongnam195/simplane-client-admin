import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/flight.dart';
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
}

class TicketRepositoryImp extends BaseRepositoryImp<Ticket>
    implements TicketRepository {
  @override
  Future<Ticket> getById(int id) async {
    return Ticket.fromJson(await ApiClient(TICKET_GET).get(params: {'id': id}));
  }

  @override
  Future<List<Ticket>> getTickets({
    required DateTime fromDate,
    required DateTime toDate,
    Map<String, dynamic>? extraQuery,
  }) async {
    await fakeDelay;
    if (extraQuery == null) {
      return allTicketsDummy;
    } else if (extraQuery['isBooked'] == true) {
      return allTicketsDummy.where((e) => e.isApproved).toList();
    } else if (extraQuery['isBooked'] == false) {
      return allTicketsDummy.where((e) => !e.isBooked).toList();
    } else if (extraQuery['isPending'] == true) {
      return allTicketsDummy.where((e) => e.isPending).toList();
    } else {
      return allTicketsDummy;
    }

    // TODO: chưa có API

    // Map<String, dynamic> customQuery = {
    //   'fromDate': fromDate.toIso8601String(),
    //   'toDate': toDate.toIso8601String(),
    // };

    // customQuery.addAll(extraQuery ?? {});

    // return Ticket.mapToList(
    //     await getListFromApi(apiUrl: TICKET_GETS, customQuery: customQuery));
  }
}
