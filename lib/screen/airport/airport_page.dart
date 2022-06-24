import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/screen/airport/airport_form_update.dart';
import 'package:simplane_client_admin/screen/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/home/home_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';

class AirportPage extends StatefulWidget {
  static const pageName = 'report';

  const AirportPage({Key? key}) : super(key: key);

  @override
  State<AirportPage> createState() => _AirportPageState();
}

class _AirportPageState extends State<AirportPage> {
  late final _isManager;
  late var data = airportsDummy;

  @override
  void initState() {
    // _selectedYear = DateTime.now().year;
    // homeBloc.add(LoadReport(_selectedYear));
    _isManager = UserManager.instance.getUser()!.isAdmin;
    super.initState();
  }

  _loadAirport() => homeBloc.add(LoadAirport(data));

  @override
  Widget build(BuildContext context) {
    return  BlocListener<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (prev, curr) =>
          curr is AirportUpdated ||
          curr is AirportDeleted ||
          curr is DataLoadFailed,
      listener: (context, state) {
        if (state is AirportUpdated) {
          setState(() {
            data = state.airports;
          });
        } else if (state is AirportDeleted) {
            setState(() {
            data = state.airports;
          });
        }  else if (state is DataLoadFailed) {
          //TODO: show error dialog
        }
      },
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 2.5,
        children: [
          for (var airport in data)
            InkWell(
              onTap: () async {
                await _showAirportFormUpdate(airport);
                _loadAirport();
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
            ),
        ],
      ),
    );
  } // Page

  _showAirportFormUpdate(Airport airport) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: AirportFormUpdate(airport));
        });
  }
}
