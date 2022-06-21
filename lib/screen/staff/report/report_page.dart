import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/model/monthly_report.dart';
import 'package:simplane_client_admin/screen/staff/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/staff/home/home_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/utils.dart';

import '../../../util/print_pdf.dart';

class ReportPage extends StatefulWidget {
  static const pageName = 'report';

  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late int _selectedYear;

  AnnualReport? _data;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _selectedYear = DateTime.now().year;
    homeBloc.add(LoadReport(_selectedYear));
    super.initState();
  }

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
                    homeBloc.add(LoadReport(_selectedYear));
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
                          homeBloc.add(LoadReport(_selectedYear));
                        },
                ),
              ],
            ),
          ),
          BlocListener<HomeBloc, HomeState>(
            bloc: homeBloc,
            listenWhen: (previous, current) =>
                current is ReportLoaded ||
                current is DataLoading ||
                current is DataLoadFailed,
            listener: (context, state) {
              if (state is DataLoading) {
                setState(() {
                  _isLoading = true;
                });
              } else if (state is ReportLoaded) {
                setState(() {
                  _isLoading = false;
                  _data = state.report;
                });
              } else if (state is DataLoadFailed) {
                //TODO: show error dialog
              }
            },
            child: Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(20),
                      child: DataTable(
                        border: TableBorder.all(),
                        headingTextStyle:
                            AppStyle.heading.copyWith(fontSize: 16),
                        columns: [
                          DataColumn(
                            label: Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(S.current.month)),
                          ),
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
          padding: const EdgeInsets.all(30),
          child: FloatingActionButton(
            backgroundColor: AppColor.primary,
            child: const Icon(Icons.print),
            onPressed: () async {
              final pdfFile = await Pdf.generateReport(_data);
              Pdf.openFile(pdfFile);
            },
          ),
        ),
      )
    ]);
  }  // Page
}
