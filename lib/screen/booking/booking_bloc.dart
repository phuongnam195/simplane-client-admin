import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/model/passenger.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/repository/ticket_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

//region EVENT
abstract class BookingEvent {}

class ConfirmBooking extends BookingEvent {
  final Flight flight;
  final Passenger passenger;
  final String ticketClassId;
  final double price;

  ConfirmBooking(
      {required this.flight,
      required this.passenger,
      required this.ticketClassId,
      required this.price});
}
//endregion

//region STATE
abstract class BookingState {}

class BookingLoading extends BookingState {}

class BookingError extends BookingState {
  final String error;

  BookingError(this.error);
}

class BookingConfirmed extends BookingState {
  final Ticket ticket;

  BookingConfirmed(this.ticket);
}
//endregion

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingLoading()) {
    on<ConfirmBooking>(_onConfirmBooking);
  }

  _onConfirmBooking(ConfirmBooking event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    TicketRepository ticketRepo = Get.find();
    try {
      final ticket = await ticketRepo.bookTicket(
        flightCode: event.flight.code,
        flightDate: event.flight.dateTime,
        passenger: event.passenger,
        ticketClassId: event.ticketClassId,
        price: event.price,
        bookedTime: DateTime.now(),
      );
      emit(BookingConfirmed(ticket));
    } catch (e) {
      emit(BookingError(e.toString()));
      Logger.e('BookingBloc -> _onConfirmBooking()', '$e');
    }
  }
}
