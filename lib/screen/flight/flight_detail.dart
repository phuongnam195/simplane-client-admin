import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/screen/booking/booking_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/date_time_utils.dart';

class FlightDetail extends StatelessWidget {
  final Flight data;

  const FlightDetail(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketClasses = RuleManager.instance.getListTicketClass();

    return SizedBox(
      width: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.code,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        data.fromAirport.name,
                        style: AppStyle.title,
                      ),
                      Text(
                        data.fromAirport.code,
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
                        data.toAirport.name,
                        style: AppStyle.title,
                      ),
                      Text(
                        data.toAirport.code,
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
                        DateTimeUtils.formatDateTimeWOSec(data.dateTime)),
                    _wxInfo(S.current.flight_duration,
                        DateTimeUtils.formatDuration(data.duration.toInt())),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ticketClasses.map((tc) {
                      String title = S.current.class_seat_count(tc.enName);
                      int fullAmount = data.seatAmount[tc.id]?.toInt() ?? 0;
                      int bookedAmount = data.bookedAmount[tc.id]?.toInt() ?? 0;
                      String value = '$bookedAmount/$fullAmount';
                      return _wxInfo(title, value);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          if (data.middleAirports.isNotEmpty)
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
              rows: Iterable<int>.generate(data.middleAirports.length)
                  .toList()
                  .map((i) => DataRow(cells: [
                        DataCell(Text(
                          data.middleAirports[i].name +
                              ' (' +
                              data.middleAirports[i].code +
                              ')',
                          textAlign: TextAlign.center,
                        )),
                        DataCell(Text(
                          DateTimeUtils.formatDuration(
                              data.stopDurations[i].toInt()),
                          textAlign: TextAlign.center,
                        )),
                      ]))
                  .toList(),
            ),
          ElevatedButton(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Text(
                  S.current.booking,
                  style: AppStyle.content.copyWith(color: Colors.white),
                )),
            onPressed: () {
              Get.toNamed(BookingScreen.routeName, arguments: data);
            },
            style: ElevatedButton.styleFrom(
              primary: AppColor.primary,
              shape: const StadiumBorder(),
            ),
          ),
        ],
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
