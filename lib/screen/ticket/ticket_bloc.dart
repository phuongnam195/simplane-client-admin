import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/return_ticket_state.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/repository/ticket_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';
import 'package:simplane_client_admin/util/my_exception.dart';

//region EVENT
abstract class TicketEvent {}

class LoadTickets extends TicketEvent {
  final DateTime fromDate;
  final DateTime toDate;
  final Map<String, dynamic> extraQuery;

  LoadTickets(this.fromDate, this.toDate, this.extraQuery);
}

class ReturnTicket extends TicketEvent {
  final Ticket ticket;

  ReturnTicket(this.ticket);
}

class ConfirmReturn extends TicketEvent {
  final Ticket ticket;

  ConfirmReturn(this.ticket);
}
//endregion

//region STATE
abstract class TicketState {}

class TicketLoading extends TicketState {}

class TicketsLoaded extends TicketState {
  final List<Ticket> tickets;

  TicketsLoaded(this.tickets);
}

class TicketReturnFee extends TicketState {
  final double fee;

  TicketReturnFee(this.fee);
}

class TicketReturned extends TicketState {}

class TicketError extends TicketState {
  final String error;

  TicketError(this.error);
}
//endregion

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketLoading()) {
    on<LoadTickets>(_onLoadTickets);
    on<ReturnTicket>(_onReturnTicket);
    on<ConfirmReturn>(_onConfirmReturn);
  }

  _onLoadTickets(LoadTickets event, Emitter<TicketState> emit) async {
    emit(TicketLoading());
    TicketRepository repo = Get.find();
    try {
      var tickets = await repo.getTickets(
          fromDate: event.fromDate,
          toDate: event.toDate,
          extraQuery: event.extraQuery);
      emit(TicketsLoaded(tickets));
    } catch (e) {
      emit(TicketError(e.toString()));
      Logger.e('TicketBloc -> _onLoadTickets()', '$e');
    }
  }

  _onReturnTicket(ReturnTicket event, Emitter<TicketState> emit) async {
    emit(TicketLoading());
    TicketRepository repo = Get.find();
    final ticket = event.ticket;
    try {
      final returnState = ticket.returnState;
      if (returnState is Returnable) {
        await repo.deleteTicket(ticket.id);
        emit(TicketReturnFee(returnState.fee));
      } else if (returnState is OverdueReturning) {
        throw MyException(S.current.ticket_return_overdued);
      } else if (returnState is NotSuitableTicketClass) {
        throw MyException(S.current.ticket_return_not_suitable);
      }
    } catch (e) {
      emit(TicketError(e.toString()));
      Logger.e('TicketBloc -> _onReturnTicket()', '$e');
    }
  }

  _onConfirmReturn(ConfirmReturn event, Emitter<TicketState> emit) async {
    emit(TicketLoading());
    TicketRepository repo = Get.find();
    final ticket = event.ticket;
    try {
      await repo.deleteTicket(ticket.id);
      emit(TicketReturned());
    } catch (e) {
      emit(TicketError(e.toString()));
      Logger.e('TicketBloc -> _onConfirmReturn()', '$e');
    }
  }
}
