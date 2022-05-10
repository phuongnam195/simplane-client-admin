import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:simplane_client_admin/core/base_mixin_function.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';
import 'package:simplane_client_admin/screen/employee/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/employee/home/home_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';

class FlightPage extends StatefulWidget {
  static const pageName = 'flight';

  const FlightPage({Key? key}) : super(key: key);

  @override
  State<FlightPage> createState() => _FlightPageState();
}

class _FlightPageState extends State<FlightPage> with DatePickerFunction {
  static const int sortCode = 0;
  static const int sortFlightDate = 1;

  List<Flight> data = [];
  List<Flight> dataToShow = [];
  bool isLoading = false;

  bool isAscending = true;
  int sortType = sortCode;

  final listTicketClass = RuleManager.instance.getListTicketClass();

  final Map<String, double> colWidths = {
    'code': 120,
    'from': 150,
    'to': 150,
    'date': 150,
    'duration': 150,
    'seat': 150,
  };
  double get tableWidth =>
      colWidths.values.fold<double>(0, (v, e) => v + e) -
      colWidths['seat']! +
      listTicketClass.length * colWidths['seat']!;

  @override
  void initState() {
    homeBloc.add(LoadFlights(fromDate, toDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
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
                    textStyle: AppStyle.subtitle,
                  ),
                  onPressed: () => showDateFilterDialog(context),
                ),
              )
            ],
          ),
          BlocListener(
            bloc: homeBloc,
            listenWhen: (previous, current) =>
                current is FlightsLoaded || current is DataLoading,
            listener: (context, state) {
              if (state is DataLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is FlightsLoaded) {
                setState(() {
                  isLoading = false;
                  data = state.flights;
                  dataToShow = data;
                });
              } else if (state is LoadDataFailed) {
                //TODO: show error dialog
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
                itemCount: dataToShow.length,
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
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            S.current.flight_code +
                (sortType == sortCode ? (isAscending ? '↓' : '↑') : ''),
            colWidths['code']!),
        onPressed: () {
          sortType = sortCode;
          isAscending = !isAscending;
          dataToShow.sort(
              ((a, b) => (isAscending ? 1 : -1) * a.code.compareTo(b.code)));
          setState(() {});
        },
      ),
      _getTitleItemWidget(S.current.from_airport, colWidths['from']!),
      _getTitleItemWidget(S.current.to_airport, colWidths['to']!),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            S.current.flight_date +
                (sortType == sortFlightDate ? (isAscending ? '↓' : '↑') : ''),
            colWidths['date']!),
        onPressed: () {
          sortType = sortFlightDate;
          isAscending = !isAscending;
          dataToShow.sort(
              ((a, b) => (isAscending ? 1 : -1) * a.date.compareTo(b.date)));
          setState(() {});
        },
      ),
      _getTitleItemWidget(S.current.flight_duration, colWidths['duration']!),
      for (TicketClass tc in RuleManager.instance.getListTicketClass())
        _getTitleItemWidget(
            S.current.class_seat_count(tc.name), colWidths['seat']!),
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
    return _rightHandSideColumnRow(dataToShow[index].code, colWidths['code']!);
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return InkWell(
      onTap: () => showAboutDialog(context: context),
      child: Row(
        children: [
          _rightHandSideColumnRow(
              dataToShow[index].fromAirport.name, colWidths['from']!),
          _rightHandSideColumnRow(
              dataToShow[index].toAirport.name, colWidths['to']!),
          _rightHandSideColumnRow(
              DateTimeUtils.formatDate(dataToShow[index].date),
              colWidths['date']!),
          _rightHandSideColumnRow(
              DateTimeUtils.formatDuration(dataToShow[index].duration * 60),
              colWidths['duration']!),
          for (TicketClass tc in RuleManager.instance.getListTicketClass())
            _rightHandSideColumnRow(
              dataToShow[index].seatAmount[tc.id].toString(),
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
      dataToShow = data
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

  @override
  onDateChanged() {
    setState(() {});
  }
}
