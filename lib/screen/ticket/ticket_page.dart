import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:simplane_client_admin/core/base_mixin_function.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/screen/ticket/ticket_bloc.dart';
import 'package:simplane_client_admin/screen/ticket/ticket_detail.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';
import 'package:simplane_client_admin/util/utils.dart';

import 'choice_bar.dart';

class TicketPage extends StatefulWidget {
  static const pageName = 'ticket';

  const TicketPage({Key? key}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> with DatePickerFunction {
  final _ticketBloc = TicketBloc();

  static const int CHOICE_ALL = 0;
  static const int CHOICE_RETURNABLE = 1;
  static const int CHOICE_DEPARTED = 2;
  static const int CHOICE_NOT_DEPARTED = 3;

  static const int SORT_FLIGHT_CODE = 0;
  static const int SORT_FLIGHT_DATE = 1;
  static const int SORT_TICKET_CLASS = 2;
  static const int SORT_PRICE = 3;
  static const int SORT_BOOKED_TIME = 4;

  List<Ticket> _data = [];
  List<Ticket> _dataToShow = [];

  bool isAscending = true;
  int sortType = SORT_FLIGHT_CODE;
  int choiceType = CHOICE_ALL;

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
    _loadTickets();
    super.initState();
  }

  _loadTickets() {
    Map<String, dynamic> extraQuery = {};
    if (choiceType == CHOICE_RETURNABLE) {
      extraQuery['filterReturnable'] = true;
    }

    if (choiceType == CHOICE_DEPARTED) {
      extraQuery['filterDeparted'] = true;
    }

    if (choiceType == CHOICE_NOT_DEPARTED) {
      extraQuery['filterDeparted'] = false;
    }

    _ticketBloc.add(LoadTickets(fromDate, toDate, extraQuery));
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
          const SizedBox(height: 10),
          ChoiceBar(
            {
              S.current.all: () {
                choiceType = CHOICE_ALL;
                _loadTickets();
              },
              S.current.returnable: () {
                choiceType = CHOICE_RETURNABLE;
                _loadTickets();
              },
              S.current.departed: () {
                choiceType = CHOICE_DEPARTED;
                _loadTickets();
              },
              S.current.not_departed: () {
                choiceType = CHOICE_NOT_DEPARTED;
                _loadTickets();
              },
            },
          ),
          const SizedBox(height: 10),
          BlocListener<TicketBloc, TicketState>(
            bloc: _ticketBloc,
            listenWhen: (prev, curr) =>
                curr is TicketsLoaded ||
                curr is TicketLoading ||
                curr is TicketError,
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is TicketLoading) {
                EasyLoading.show();
              } else if (state is TicketsLoaded) {
                setState(() {
                  _data = state.tickets;
                  _dataToShow = _data;
                });
              } else if (state is TicketError) {
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
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(S.current.ticket_code, colWidths['code']!),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.flight_code +
                (sortType == SORT_FLIGHT_CODE ? (isAscending ? '↓' : '↑') : ''),
            colWidths['flightCode']!),
        onPressed: () {
          sortType = SORT_FLIGHT_CODE;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) * a.flightCode.compareTo(b.flightCode)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.flight_date +
                (sortType == SORT_FLIGHT_DATE ? (isAscending ? '↓' : '↑') : ''),
            colWidths['flightDate']!),
        onPressed: () {
          sortType = SORT_FLIGHT_DATE;
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
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.ticket_class +
                (sortType == SORT_TICKET_CLASS
                    ? (isAscending ? '↓' : '↑')
                    : ''),
            colWidths['ticketClass']!),
        onPressed: () {
          sortType = SORT_TICKET_CLASS;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) *
              a.ticketClassId.compareTo(b.ticketClassId)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.price +
                (sortType == SORT_PRICE ? (isAscending ? '↓' : '↑') : ''),
            colWidths['price']!),
        onPressed: () {
          sortType = SORT_PRICE;
          isAscending = !isAscending;
          _dataToShow.sort(
              ((a, b) => (isAscending ? 1 : -1) * a.price.compareTo(b.price)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.booked_time +
                (sortType == SORT_BOOKED_TIME ? (isAscending ? '↓' : '↑') : ''),
            colWidths['bookedTime']!),
        onPressed: () {
          sortType = SORT_PRICE;
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
    return _rightHandSideColumnRow(_dataToShow[index].id, colWidths['code']!);
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        _showTicketDetail(_dataToShow[index]);
      },
      child: Row(
        children: [
          _rightHandSideColumnRow(
              _dataToShow[index].flightCode, colWidths['flightCode']!),
          _rightHandSideColumnRow(
              DateTimeUtils.formatDateTimeWOSec(_dataToShow[index].flightDate),
              colWidths['flightDate']!),
          _rightHandSideColumnRow(
              _dataToShow[index].passenger.name, colWidths['passenger']!),
          _rightHandSideColumnRow(_dataToShow[index].passenger.identityNumber,
              colWidths['identity']!),
          _rightHandSideColumnRow(
              _dataToShow[index].passenger.phoneNumber, colWidths['phone']!),
          _rightHandSideColumnRow(
              _dataToShow[index].ticketClassId, colWidths['ticketClass']!),
          _rightHandSideColumnRow(
              formatCurrency(_dataToShow[index].price), colWidths['price']!),
          _rightHandSideColumnRow(
              DateTimeUtils.formatDateTime(_dataToShow[index].bookedTime),
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
    _loadTickets();
  }

  _onSearch(String keyword) {
    setState(() {
      _dataToShow = _data
          .where((e) => [
                e.id,
                e.flightCode,
                e.passenger.name,
                e.passenger.identityNumber,
                e.passenger.phoneNumber,
              ].join('###').toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }

  _showTicketDetail(Ticket ticket) async {
    final message = await showDialog(
        context: context,
        builder: (context) {
          return TicketDetail(ticket);
        });
    if (message is String) {
      EasyLoading.showSuccess(message);
      _loadTickets();
    }
  }
}
