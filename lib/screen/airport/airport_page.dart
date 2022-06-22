import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/screen/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/home/home_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/utils.dart';

import '../../../util/print_pdf.dart';

class AirportPage extends StatefulWidget {
  static const pageName = 'report';

  const AirportPage({Key? key}) : super(key: key);

  @override
  State<AirportPage> createState() => _AirportPageState();
}

class _AirportPageState extends State<AirportPage> {
  late int _selectedYear;
  late final _isManager;

  AnnualReport? _data;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // _selectedYear = DateTime.now().year;
    // homeBloc.add(LoadReport(_selectedYear));
    _isManager = UserManager.instance.getUser()!.isAdmin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 8.0,
      children: [
        for (var airport in airportsDummy)
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    airport.code,
                    style: AppStyle.heading,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            S.current.name_airport,
                            style: AppStyle.title,
                          ),
                          Text(
                            airport.name,
                            style: AppStyle.content,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            S.current.address_airport,
                            style: AppStyle.title,
                          ),
                          Text(
                            airport.address,
                            style: AppStyle.content,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  } // Page
}
