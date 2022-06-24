import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/screen/report/report_bloc.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/utils.dart';

class ReportPage extends StatefulWidget {
  static const pageName = 'report';

  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _reportBloc = ReportBloc();
  late int _selectedYear;
  final _isManager = UserManager.instance.getUser()!.isAdmin;

  AnnualReport? _data;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _selectedYear = DateTime.now().year;
    _loadReport();
    super.initState();
  }

  _loadReport() => _reportBloc.add(LoadReport(_selectedYear));

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              S.current.annual_revenue_report.toUpperCase(),
              style: AppStyle.heading,
            ),
          ),
          SizedBox(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  iconSize: 20,
                  onPressed: () {
                    _selectedYear--;
                    _loadReport();
                  },
                ),
                Text(
                  '$_selectedYear',
                  style: AppStyle.content,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  iconSize: 20,
                  onPressed: _selectedYear == DateTime.now().year
                      ? null
                      : () {
                          _selectedYear++;
                          _loadReport();
                        },
                ),
              ],
            ),
          ),
          BlocListener<ReportBloc, ReportState>(
            bloc: _reportBloc,
            listenWhen: (previous, current) =>
                current is ReportLoaded ||
                current is ReportLoading ||
                current is ReportError,
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is ReportLoading) {
                EasyLoading.show();
              } else if (state is ReportLoaded) {
                setState(() {
                  _data = state.report;
                });
              } else if (state is ReportError) {
                EasyLoading.showError(state.error);
              }
            },
            child: Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(20),
                child: DataTable(
                  border: TableBorder.all(),
                  headingTextStyle: AppStyle.heading.copyWith(fontSize: 16),
                  columns: [
                    DataColumn(
                      label: Container(
                          alignment: Alignment.center,
                          width: 50,
                          child: Text(S.current.month)),
                    ),
                    if (_isManager)
                      DataColumn(
                          label: Container(
                              alignment: Alignment.center,
                              width: 135,
                              child: Text(S.current.flight_count))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            width: 135,
                            child: Text(S.current.ticket_count))),
                    DataColumn(
                        label: Container(
                            alignment: Alignment.center,
                            width: 100,
                            child: Text(S.current.revenue))),
                  ],
                  rows: (_data?.monthlyReports ?? [])
                      .map(
                        (rp) => DataRow(
                          cells: [
                            DataCell(Align(
                                alignment: Alignment.center,
                                child: Text(rp.month.toString()))),
                            if (_isManager)
                              DataCell(Align(
                                  alignment: Alignment.center,
                                  child: Text(rp.flightCount.toString()))),
                            DataCell(Align(
                                alignment: Alignment.centerRight,
                                child: Text(rp.ticketCount.toString()))),
                            DataCell(Align(
                                alignment: Alignment.centerRight,
                                child: Text(formatCurrency(rp.revenue)))),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
            backgroundColor: AppColor.secondary,
            child: const Icon(Icons.print),
            onPressed: _data != null
                ? () => _reportBloc.add(PrintReport(_data!))
                : null,
          ),
        ),
      )
    ]);
  } // Page
}
