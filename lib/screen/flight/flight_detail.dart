import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/screen/booking/booking_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';

class FlightDetail extends StatelessWidget {
  final Flight flight;

  const FlightDetail(this.flight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketClasses = RuleManager.instance.rule!.ticketClasses;

    return AlertDialog(
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              flight.code,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          flight.fromAirport.name,
                          style: AppStyle.title,
                        ),
                        Text(
                          flight.fromAirport.code,
                          style: AppStyle.heading,
                        ),
                      ],
                    ),
                    Transform.rotate(
                        angle: 90 * math.pi / 180,
                        child: Icon(
                          Icons.flight,
                          size: 40,
                          color: AppColor.primary.withOpacity(0.5),
                        )),
                    Column(
                      children: [
                        Text(
                          flight.toAirport.name,
                          style: AppStyle.title,
                        ),
                        Text(
                          flight.toAirport.code,
                          style: AppStyle.heading,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _wxInfo(S.current.flight_datetime,
                          DateTimeUtils.formatDateTimeWOSec(flight.dateTime)),
                      _wxInfo(
                          S.current.flight_duration,
                          DateTimeUtils.formatDuration(
                              flight.duration.toInt())),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ticketClasses.map((tc) {
                        String title = S.current.class_seat_count(tc.enName);
                        int fullAmount = flight.seatAmount[tc.id]?.toInt() ?? 0;
                        int bookedAmount =
                            flight.bookedAmount[tc.id]?.toInt() ?? 0;
                        String value = '$bookedAmount/$fullAmount';
                        return _wxInfo(title, value);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            if (flight.middleAirports.isNotEmpty)
              DataTable(
                headingTextStyle: AppStyle.content,
                dataTextStyle: AppStyle.subtitle,
                columns: [
                  DataColumn(
                      label: Text(
                    S.current.intermediate_airport,
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text(
                    S.current.stop_duration,
                    textAlign: TextAlign.center,
                  )),
                ],
                rows: Iterable<int>.generate(flight.middleAirports.length)
                    .toList()
                    .map((i) => DataRow(cells: [
                          DataCell(Text(
                            flight.middleAirports[i].name +
                                ' (' +
                                flight.middleAirports[i].code +
                                ')',
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            DateTimeUtils.formatDuration(
                                flight.stopDurations[i].toInt()),
                            textAlign: TextAlign.center,
                          )),
                        ]))
                    .toList(),
              ),
            if (UserManager.instance.getUser()!.isAdmin == false)
              ElevatedButton(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      S.current.booking,
                      style: AppStyle.content.copyWith(color: Colors.white),
                    )),
                onPressed: !flight.canBook
                    ? null
                    : () async {
                        final ok = await Get.toNamed(BookingScreen.routeName,
                            arguments: flight);
                        Get.back(result: ok);
                      },
                style: ElevatedButton.styleFrom(
                  primary: AppColor.primary,
                  shape: const StadiumBorder(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _wxInfo(String title, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyle.title,
            ),
            Text(
              value,
              style: AppStyle.content,
            ),
          ],
        ),
      );
}
