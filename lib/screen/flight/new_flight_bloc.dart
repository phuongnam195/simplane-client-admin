//region EVENT
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

abstract class NewFlightEvent {}

class AddFlight extends NewFlightEvent {
  final String flightCode;
  final Airport fromAirport;
  final Airport toAirport;
  final DateTime flightDate;
  final double duration;
  final Map<String, double> ticketClassPrice;
  final Map<String, double> seatAmount;
  final Map<String, double> bookedAmount;
  final List<Airport> middleAirports;
  final List<double> stopDurations;

  AddFlight(
      {required this.flightCode,
      required this.fromAirport,
      required this.toAirport,
      required this.flightDate,
      required this.duration,
      required this.ticketClassPrice,
      required this.seatAmount,
      required this.bookedAmount,
      required this.middleAirports,
      required this.stopDurations});
}

//endregion

//region STATE
abstract class NewFlightState {}

class NewFlightLoading extends NewFlightState {}

class NewFlightError extends NewFlightState {
  final String error;

  NewFlightError(this.error);
}

class FlightAdded extends NewFlightState {}

//endregion

class NewFlightBloc extends Bloc<NewFlightEvent, NewFlightState> {
  NewFlightBloc() : super(NewFlightLoading()) {
    on<AddFlight>(_onAddFlight);
  }

  _onAddFlight(AddFlight event, Emitter<NewFlightState> emit) async {
    emit(NewFlightLoading());
    FlightRepository flightRepo = Get.find();
    final flight = Flight(
      id: '',
      code: event.flightCode,
      fromAirport: event.fromAirport,
      toAirport: event.toAirport,
      dateTime: event.flightDate,
      duration: event.duration,
      ticketClassPrice: event.ticketClassPrice,
      seatAmount: event.seatAmount,
      bookedAmount: event.bookedAmount,
      middleAirports: event.middleAirports,
      stopDurations: event.stopDurations,
    );
    fakeDelay;
    try {
      // await flightRepo.addFlight(flight);
      emit(FlightAdded());
    } catch (e) {
      emit(NewFlightError(e.toString()));
      Logger.e('NewFlightBloc -> _onAddFlight()', '$e');
    }
  }
}
