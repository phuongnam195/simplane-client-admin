import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/screen/ticket/ticket_bloc.dart';
import 'package:simplane_client_admin/util/constants.dart';
import 'package:simplane_client_admin/util/utils.dart';

import '../../../util/date_time_utils.dart';

class TicketDetail extends StatelessWidget {
  final Ticket ticket;

  const TicketDetail(this.ticket, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ticketBloc = TicketBloc();

    return BlocListener<TicketBloc, TicketState>(
      bloc: ticketBloc,
      listenWhen: (prev, curr) =>
          curr is TicketReturnFee ||
          curr is TicketReturned ||
          curr is TicketError ||
          curr is TicketLoading,
      listener: (ctx, state) {
        EasyLoading.dismiss();
        if (state is TicketLoading) {
          EasyLoading.show();
        } else if (state is TicketError) {
          EasyLoading.showError(state.error);
        } else if (state is TicketReturnFee) {
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                      title: Text(
                        S.current.confirm,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Text(S.current
                          .ticket_return_confirm(formatCurrency(state.fee))),
                      actions: [
                        TextButton(
                          child: Text(
                            S.current.cancel,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () => Get.back(result: false),
                        ),
                        TextButton(
                          child: Text(
                            S.current.agree,
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () =>
                              ticketBloc.add(ConfirmReturn(ticket)),
                        ),
                      ]));
        } else if (state is TicketReturned) {
          Get.back(result: S.current.ticket_returned_successfully);
        }
      },
      child: AlertDialog(
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ticket.id,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        _wxInfo(S.current.flight_code, ticket.flightCode),
                        _wxInfo(S.current.ticket_class, ticket.ticketClassId),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _wxInfo(
                            S.current.flight_datetime,
                            DateTimeUtils.formatDateTimeWOSec(
                                ticket.flightDate)),
                        _wxInfo(S.current.price, formatCurrency(ticket.price)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _wxInfo(S.current.passenger, ticket.passenger.name),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                    ),
                    _wxInfo(S.current.identity_number,
                        ticket.passenger.identityNumber),
                    const Padding(
                      padding: EdgeInsets.only(right: 20),
                    ),
                    _wxInfo(
                        S.current.phone_number, ticket.passenger.phoneNumber),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      S.current.return_ticket,
                      style: AppStyle.content.copyWith(color: Colors.white),
                    )),
                onPressed: () => ticketBloc.add(ReturnTicket(ticket)),
                style: ElevatedButton.styleFrom(
                  primary: AppColor.secondary,
                  shape: const StadiumBorder(),
                ),
              ),
            ],
          ),
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
