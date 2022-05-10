import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:simplane_client_admin/core/base_mixin_function.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/screen/employee/home/home_bloc.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';
import 'package:simplane_client_admin/util/utils.dart';

import '../home_screen.dart';

class TicketPage extends StatefulWidget {
  static const pageName = 'ticket';

  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> with DatePickerFunction {
  static const int sortFlightCode = 0;
  static const int sortFlightDate = 1;
  static const int sortTicketClass = 2;
  static const int sortPrice = 3;
  static const int sortBookedTime = 4;

  List<Ticket> _data = [];
  List<Ticket> _dataToShow = [];
  bool _isLoading = false;

  bool isAscending = true;
  int sortType = sortFlightCode;

  final Map<String, double> colWidths = {
    'code': 120,
    'flightCode': 120,
    'flightDate': 150,
    'passenger': 150,
    'identity': 120,
    'phone': 120,
    'ticketClass': 100,
    'price': 120,
    'bookedTime': 150,
  };
  double get tableWidth => colWidths.values.fold<double>(0, (v, e) => v + e);

  @override
  void initState() {
    homeBloc.add(LoadTickets(fromDate, toDate, {}));
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
                    textStyle: AppStyle.title,
                  ),
                  onPressed: () => showDateFilterDialog(context),
                ),
              )
            ],
          ),
          BlocListener<HomeBloc, HomeState>(
            bloc: homeBloc,
            listenWhen: (previous, current) =>
                current is TicketsLoaded || current is DataLoading,
            listener: (context, state) {
              if (state is DataLoading) {
                setState(() {
                  _isLoading = true;
                });
              } else if (state is TicketsLoaded) {
                setState(() {
                  _isLoading = false;
                  _data = state.tickets;
                  _dataToShow = _data;
                });
              } else if (state is LoadDataFailed) {
                //TODO: show error dialog
              }
            },
            child: Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : HorizontalDataTable(
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
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(S.current.ticket_code, colWidths['code']!),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            S.current.flight_code +
                (sortType == sortFlightCode ? (isAscending ? '↓' : '↑') : ''),
            colWidths['flightCode']!),
        onPressed: () {
          sortType = sortFlightCode;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) * a.flightCode.compareTo(b.flightCode)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            S.current.flight_date +
                (sortType == sortFlightDate ? (isAscending ? '↓' : '↑') : ''),
            colWidths['flightDate']!),
        onPressed: () {
          sortType = sortFlightDate;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) * a.flightDate.compareTo(b.flightDate)));
          setState(() {});
        },
      ),
      _getTitleItemWidget(S.current.passenger, colWidths['passenger']!),
      _getTitleItemWidget(S.current.identity_number, colWidths['identity']!),
      _getTitleItemWidget(S.current.phone_number, colWidths['phone']!),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            S.current.ticket_class +
                (sortType == sortTicketClass ? (isAscending ? '↓' : '↑') : ''),
            colWidths['ticketClass']!),
        onPressed: () {
          sortType = sortTicketClass;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) *
              a.ticketClassId.compareTo(b.ticketClassId)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            S.current.price +
                (sortType == sortPrice ? (isAscending ? '↓' : '↑') : ''),
            colWidths['price']!),
        onPressed: () {
          sortType = sortPrice;
          isAscending = !isAscending;
          _dataToShow.sort(
              ((a, b) => (isAscending ? 1 : -1) * a.price.compareTo(b.price)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: _getTitleItemWidget(
            S.current.booked_time +
                (sortType == sortBookedTime ? (isAscending ? '↓' : '↑') : ''),
            colWidths['bookedTime']!),
        onPressed: () {
          sortType = sortPrice;
          isAscending = !isAscending;
          _dataToShow.sort(
              ((a, b) => (isAscending ? 1 : -1) * a.price.compareTo(b.price)));
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
      onTap: () {},
      child: Row(
        children: [
          _rightHandSideColumnRow(
              _dataToShow[index].flightCode, colWidths['flightCode']!),
          _rightHandSideColumnRow(
              DateTimeUtils.formatDateTimeWOSec(_dataToShow[index].flightDate),
              colWidths['flightDate']!),
          _rightHandSideColumnRow(_dataToShow[index].passenger?.name ?? '',
              colWidths['passenger']!),
          _rightHandSideColumnRow(
              _dataToShow[index].passenger?.identityNumber ?? '',
              colWidths['identity']!),
          _rightHandSideColumnRow(
              _dataToShow[index].passenger?.phoneNumber ?? '',
              colWidths['phone']!),
          _rightHandSideColumnRow(
              _dataToShow[index].ticketClassId, colWidths['ticketClass']!),
          _rightHandSideColumnRow(
              formatCurrency(_dataToShow[index].price) + ' d',
              colWidths['price']!),
          _rightHandSideColumnRow(
              _dataToShow[index].bookedTime != null
                  ? DateTimeUtils.formatDateTime(_dataToShow[index].bookedTime!)
                  : '',
              colWidths['bookedTime']!),
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

  @override
  onDateChanged() {
    setState(() {});
  }

  _onSearch(String keyword) {
    setState(() {
      _dataToShow = _data
          .where((e) => [
                e.code,
                e.flightCode,
                e.passenger?.name ?? '',
                e.passenger?.identityNumber ?? '',
                e.passenger?.phoneNumber ?? '',
              ].join('###').toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }
}
