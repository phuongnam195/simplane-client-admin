import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';
import 'package:simplane_client_admin/network/api_path.dart';

import '../dummy_data.dart';

class RuleManager {
  static final RuleManager instance = RuleManager._internal();
  RuleManager._internal();

  List<Airport> _listAirport = [];
  List<TicketClass> _listTicketClass = [];

  List<Airport> getListAirport() => _listAirport;
  List<TicketClass> getListTicketClass() => _listTicketClass;

  Airport? getAirport(String code) =>
      _listAirport.firstWhere((e) => e.code == code);

  TicketClass? getTicketClass(String id) =>
      _listTicketClass.firstWhere((e) => e.id == id);

  Future<void> load() async {
    // TODO: chưa có API
    // _listTicketClass = TicketClass.mapToList(await getListFromApi(apiUrl: TICKET_CLASS_GETS));
    _listAirport = airportsDummy;
    _listTicketClass = ticketClassesDummy;
  }
}
