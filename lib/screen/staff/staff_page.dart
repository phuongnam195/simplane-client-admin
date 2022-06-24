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
import 'package:simplane_client_admin/model/staff.dart';
import 'package:simplane_client_admin/model/ticket_class.dart';
import 'package:simplane_client_admin/screen/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/home/home_screen.dart';
import 'package:simplane_client_admin/screen/flight/flight_detail.dart';
import 'package:simplane_client_admin/screen/staff/staff_bloc.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';
import 'package:simplane_client_admin/util/utils.dart';

class StaffPage extends StatefulWidget {
  static const pageName = 'staff';

  const StaffPage({Key? key}) : super(key: key);

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final _staffBloc = StaffBloc();

  static const int sortCode = 0;
  static const int sortFlightDate = 1;

  List<Staff> _data = [];
  List<Staff> _dataToShow = [];
  bool _isLoading = false;

  bool isAscending = true;
  int sortType = sortCode;

  final ticketClasses = RuleManager.instance.getListTicketClass();

  final Map<String, double> colWidths = {
    'id': 120,
    'username': 150,
    'fullname': 150,
    'tickets': 200,
    'revenue': 150,
  };
  double get tableWidth => colWidths.values.fold<double>(0, (v, e) => v + e);

  @override
  void initState() {
    _loadStaffs();
    super.initState();
  }

  _loadStaffs() => _staffBloc.add(LoadStaffs());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              child: SizedBox(
                width: 700,
                child: Card(
                    elevation: 1.0,
                    child: TextField(
                        decoration: InputDecoration(
                            hintText: S.current.staff_search_hint,
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
            BlocListener<StaffBloc, StaffState>(
              bloc: _staffBloc,
              listenWhen: (previous, current) =>
                  current is StaffsLoaded ||
                  current is StaffLoading ||
                  current is StaffError,
              listener: (context, state) {
                if (state is StaffLoading) {
                  setState(() {
                    _isLoading = true;
                  });
                } else if (state is StaffsLoaded) {
                  setState(() {
                    _isLoading = false;
                    _data = state.staffs;
                    _dataToShow = _data;
                  });
                } else if (state is StaffError) {
                  EasyLoading.showError(state.error);
                }
              },
              child: Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : HorizontalDataTable(
                        leftHandSideColumnWidth: colWidths['id']!,
                        rightHandSideColumnWidth: tableWidth - colWidths['id']!,
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
          ])
        ],
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.id +
                (sortType == sortCode ? (isAscending ? '↓' : '↑') : ''),
            colWidths['id']!),
        onPressed: () {
          sortType = sortCode;
          isAscending = !isAscending;
          _dataToShow
              .sort(((a, b) => (isAscending ? 1 : -1) * a.id.compareTo(b.id)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.username +
                (sortType == sortCode ? (isAscending ? '↓' : '↑') : ''),
            colWidths['username']!),
        onPressed: () {
          sortType = sortCode;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) * a.username.compareTo(b.username)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.fullname +
                (sortType == sortCode ? (isAscending ? '↓' : '↑') : ''),
            colWidths['fullname']!),
        onPressed: () {
          sortType = sortCode;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) * a.fullname.compareTo(b.fullname)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.ticket_count +
                (sortType == sortFlightDate ? (isAscending ? '↓' : '↑') : ''),
            colWidths['tickets']!),
        onPressed: () {
          sortType = sortFlightDate;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) * a.totalTicket.compareTo(b.totalTicket)));
          setState(() {});
        },
      ),
      TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        child: _getTitleItemWidget(
            S.current.revenue +
                (sortType == sortFlightDate ? (isAscending ? '↓' : '↑') : ''),
            colWidths['revenue']!),
        onPressed: () {
          sortType = sortFlightDate;
          isAscending = !isAscending;
          _dataToShow.sort(((a, b) =>
              (isAscending ? 1 : -1) *
              a.totalRevenue.compareTo(b.totalRevenue)));
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
    return _rightHandSideColumnRow(_dataToShow[index].id, colWidths['id']!);
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return InkWell(
      onLongPress: () => _onDelete(_dataToShow[index].id),
      child: Row(
        children: [
          _rightHandSideColumnRow(
              _dataToShow[index].username, colWidths['username']!),
          _rightHandSideColumnRow(
              _dataToShow[index].fullname, colWidths['fullname']!),
          _rightHandSideColumnRow(
              _dataToShow[index].totalTicket.toInt().toString(),
              colWidths['tickets']!),
          _rightHandSideColumnRow(
              formatCurrency(_dataToShow[index].totalRevenue),
              colWidths['revenue']!),
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

  _onDelete(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocListener<StaffBloc, StaffState>(
            bloc: _staffBloc,
            listenWhen: (prev, curr) => curr is StaffDeleted,
            listener: (ctx, state) {
              if (state is StaffDeleted) {
                _loadStaffs();
                Get.back();
              }
            },
            child: AlertDialog(
              title: Text(
                S.current.delete_staff,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(S.current.delete_staff_confirm),
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
                    _staffBloc.add(DeleteStaff(id));
                  },
                ),
              ],
            ),
          );
        });
  }

  _onSearch(String keyword) {
    setState(() {
      _dataToShow = _data
          .where((e) => [
                e.id,
                e.username,
                e.fullname,
              ].join('###').toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    });
  }
}
