import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/utils.dart';

import '../../../util/date_time_utils.dart';

class TicketDetail extends StatelessWidget {
  final Ticket data;

  const TicketDetail(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketClasses = RuleManager.instance.getListTicketClass();

    return SizedBox(
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.id,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _wxInfo(S.current.flight_code, data.flightCode),
                    _wxInfo(S.current.ticket_class, data.ticketClassId),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _wxInfo(S.current.flight_datetime,
                        DateTimeUtils.formatDateTimeWOSec(data.flightDate)),
                    _wxInfo(S.current.price, formatCurrency(data.price)),
                  ],
                ),
              ],
            ),
          ),
          if (data.passenger != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _wxInfo(S.current.passenger, data.passenger.name),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                  ),
                  _wxInfo(
                      S.current.identity_number, data.passenger.identityNumber),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                  ),
                  _wxInfo(S.current.phone_number, data.passenger.phoneNumber),
                ],
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