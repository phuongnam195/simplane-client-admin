import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:simplane_client_admin/core/base_mixin_function.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';
import 'package:simplane_client_admin/screen/flight/flight_bloc.dart';
import 'package:simplane_client_admin/screen/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/home/home_screen.dart';
import 'package:simplane_client_admin/screen/flight/flight_detail.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';

import 'new_flight_screen.dart';

class FlightPage extends StatefulWidget {
  static const pageName = 'flight';

  const FlightPage({Key? key}) : super(key: key);

  @override
  State<FlightPage> createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> with DatePickerFunction {
  final _flightBloc = FlightBloc();
  static const String sortCode = 'SORT_CODE';
  static const String sortFlightDate = 'SORT_FLIGHT_DATE';
  static const String sortSeat = 'SORT_SEAT_';

  List<Flight> _data = [];
  List<Flight> _dataToShow = [];

  bool _isAscending = true;
  String _sortType = sortCode;

  final _ticketClasses = RuleManager.instance.rule!.ticketClasses;

  final Map<String, double> colWidths = {
    'code': 120,
    'from': 150,
    'to': 150,
    'date': 200,
    'duration': 150,
    'seat': 150,
  };
  double get tableWidth =>
      colWidths.values.fold<double>(0, (v, e) => v + e) -
      colWidths['seat']! +
      _ticketClasses.length * colWidths['seat']!;

  @override
  void initState() {
    _loadFlights();
    super.initState();
  }

  _loadFlights() => _flightBloc.add(LoadFlights(fromDate, toDate));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: 700,
                    child: Card(
                        elevation: 1.0,
                        child: TextField(
                            decoration: InputDecoration(
                                hintText: S.current.flight_search_hint,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.search),
                                ),
                                border: InputBorder.none),
                            onSubmitted: (value) {
                              _onSearch(value);
                            })),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      fromDate.compareTo(toDate) == 0
                          ? DateTimeUtils.formatDate(toDate)
                          : DateTimeUtils.formatDate(toDate) +
                              ' - ' +
                              DateTimeUtils.formatDate(fromDate),
                    ),
                    style: TextButton.styleFrom(
                      primary: AppColor.primary,
                      onSurface: AppColor.primary,
                      textStyle: AppStyle.title,
                    ),
                    onPressed: () => showDateFilterDialog(context),
                  ),
                )
              ],
            ),
            BlocListener<FlightBloc, FlightState>(
              bloc: _flightBloc,
              listenWhen: (previous, current) =>
                  current is FlightLoading ||
                  current is FlightError ||
                  current is FlightsLoaded,
              listener: (context, state) {
                EasyLoading.dismiss();
                if (state is FlightLoading) {
                  EasyLoading.show();
                } else if (state is FlightsLoaded) {
                  setState(() {
                    _data = state.flights;
                    _dataToShow = _data;
                  });
                } else if (state is FlightError) {
                  EasyLoading.showError(state.error);
                }
              },
              child: Expanded(
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: colWidths['code']!,
                  rightHandSideColumnWidth: tableWidth - colWidths['code']!,
                  isFixedHeader: true,
                  headerWidgets: _getTitleWidget(),
                  leftSideItemBuilder: _generateFirstColumnRow,
                  rightSideItemBuilder: _generateRightHandSideColumnRow,
                  itemCount: _dataToShow.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black54,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (UserManager.instance.getUser()?.isAdmin == true)
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                final ok = await Get.toNamed(NewFlightScreen.routeName);
                if (ok == true) {
                  _loadFlights();
                }
              },
              child: const Icon(Icons.add),
            ),
          ),
      ]),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.flight_code +
                (_sortType == sortCode ? (_isAscending ? '↓' : '↑') : ''),
            colWidths['code']!),
        onPressed: () {
          _sortType = sortCode;
          _isAscending = !_isAscending;
          _dataToShow.sort(
              ((a, b) => (_isAscending ? 1 : -1) * a.code.compareTo(b.code)));
          setState(() {});
        },
      ),
      _getTitleItemWidget(S.current.from_airport, colWidths['from']!),
      _getTitleItemWidget(S.current.to_airport, colWidths['to']!),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.flight_datetime +
                (_sortType == sortFlightDate ? (_isAscending ? '↓' : '↑') : ''),
            colWidths['date']!),
        onPressed: () {
          _sortType = sortFlightDate;
          _isAscending = !_isAscending;
          _dataToShow.sort(((a, b) =>
              (_isAscending ? 1 : -1) * a.dateTime.compareTo(b.dateTime)));
          setState(() {});
        },
      ),
      _getTitleItemWidget(S.current.flight_duration, colWidths['duration']!),
      for (TicketClass tc in _ticketClasses)
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: _getTitleItemWidget(
              S.current.class_seat_count(
                      S.current.languageCode == 'en' ? tc.enName : tc.viName) +
                  (_sortType == sortSeat + tc.id
                      ? (_isAscending ? '↓' : '↑')
                      : ''),
              colWidths['seat']!),
          onPressed: () {
            _sortType = sortSeat + tc.id;
            _isAscending = !_isAscending;
            _dataToShow.sort(((a, b) =>
                (_isAscending ? 1 : -1) *
                (a.seatAmount[tc.id] ?? 0)
                    .compareTo(b.seatAmount[tc.id] ?? 0)));
            setState(() {});
          },
        ),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: const EdgeInsets.only(left: 5),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return _rightHandSideColumnRow(_dataToShow[index].code, colWidths['code']!);
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return InkWell(
      onTap: () => _showFlightDetail(_dataToShow[index]),
      onLongPress: () => _deleteFlight(_dataToShow[index].id),
      child: Row(
        children: [
          _rightHandSideColumnRow(
              _dataToShow[index].fromAirport.name, colWidths['from']!),
          _rightHandSideColumnRow(
              _dataToShow[index].toAirport.name, colWidths['to']!),
          _rightHandSideColumnRow(
              DateTimeUtils.formatDateTimeWOSec(_dataToShow[index].dateTime),
              colWidths['date']!),
          _rightHandSideColumnRow(
              DateTimeUtils.formatDuration(
                  _dataToShow[index].duration.toInt() * 60),
              colWidths['duration']!),
          for (TicketClass tc in _ticketClasses)
            _rightHandSideColumnRow(
              _dataToShow[index].seatAmount[tc.id]?.toInt().toString() ?? '0',
              colWidths['seat']!,
            ),
        ],
      ),
    );
  }

  Widget _rightHandSideColumnRow(String value, double width,
          [Alignment? alignment]) =>
      Container(
        child: Text(value),
        width: width,
        height: 52,
        padding: const EdgeInsets.only(left: 5),
        alignment: alignment ?? Alignment.centerLeft,
      );

  _onSearch(String keyword) {
    setState(() {
      _dataToShow = _data
          .where((e) => [
                e.code,
                e.fromAirport.code,
                e.fromAirport.name,
                e.toAirport.code,
                e.toAirport.name
              ].join('###').toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  _showFlightDetail(Flight flight) async {
    final needRefresh = await showDialog(
        context: context,
        builder: (context) {
          return FlightDetail(flight);
        });
    if (needRefresh == true) {
      _loadFlights();
    }
  }

  _deleteFlight(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocListener<HomeBloc, HomeState>(
            bloc: homeBloc,
            listenWhen: (prev, curr) => curr is FlightDeleted,
            listener: (ctx, state) {
              if (state is FlightDeleted) {
                _loadFlights();
                Get.back();
              }
            },
            child: AlertDialog(
              title: Text(
                S.current.delete_flight,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(S.current.delete_flight_confirm),
              actions: [
                TextButton(
                  child: Text(
                    S.current.cancel,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  child: Text(
                    S.current.delete,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _flightBloc.add(DeleteFlight(id));
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  onDateChanged() {
    _loadFlights();
  }
}
