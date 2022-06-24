import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/screen/airport/airport_bloc.dart';
import 'package:simplane_client_admin/screen/airport/airport_form.dart';
import 'package:simplane_client_admin/util/constants.dart';

class AirportPage extends StatefulWidget {
  static const pageName = 'airport';

  const AirportPage({Key? key}) : super(key: key);

  @override
  State<AirportPage> createState() => _AirportPageState();
}

class _AirportPageState extends State<AirportPage> {
  final _airportBloc = AirportBloc();
  final List<Airport> _airports = [];
  String? _message;

  @override
  void initState() {
    _loadAirports();
    super.initState();
  }

  _loadAirports() => _airportBloc.add(LoadAirports());

  @override
  Widget build(BuildContext context) {
    return BlocListener<AirportBloc, AirportState>(
      bloc: _airportBloc,
      listenWhen: (prev, curr) =>
          curr is AirportLoading ||
          curr is AirportError ||
          curr is AirportsLoaded,
      listener: (context, state) {
        EasyLoading.dismiss();
        if (_message != null) {
          EasyLoading.showSuccess(
            _message!,
            duration: const Duration(seconds: 1),
          ).then((_) => _message = null);
        }
        if (state is AirportLoading) {
          EasyLoading.show();
        } else if (state is AirportError) {
          EasyLoading.showError(state.error);
        } else if (state is AirportsLoaded) {
          setState(() {
            _airports.clear();
            _airports.addAll(state.airports);
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.45,
              children: [
                for (var airport in _airports)
                  InkWell(
                    onTap: () => _showForm(airport),
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
                                      S.current.name,
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
                                      S.current.address,
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
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => _showForm(),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showForm([Airport? airport]) async {
    final message = await showDialog(
        context: context,
        builder: (context) {
          return AirportForm(airport);
        });
    if (message is String) {
      _message = message;
      _loadAirports();
    }
  }
}
