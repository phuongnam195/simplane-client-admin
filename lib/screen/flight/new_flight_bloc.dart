import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/repository/airport_repository.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';
import 'package:simplane_client_admin/util/my_exception.dart';

//region EVENT
abstract class NewFlightEvent {}

class InitData extends NewFlightEvent {}

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

class DataInited extends NewFlightState {
  final List<Airport> airports;

  DataInited(this.airports);
}

class FlightAdded extends NewFlightState {}
//endregion

class NewFlightBloc extends Bloc<NewFlightEvent, NewFlightState> {
  NewFlightBloc() : super(NewFlightLoading()) {
    on<InitData>(_onInitData);
    on<AddFlight>(_onAddFlight);
  }

  _onAddFlight(AddFlight event, Emitter<NewFlightState> emit) async {
    emit(NewFlightLoading());
    FlightRepository flightRepo = Get.find();
    final rule = RuleManager.instance.rule!;
    final minFlightDuration = rule.minFlightDuration.toInt();
    final minStopDuration = rule.minStopDuration.toInt();
    final maxStopDuration = rule.maxStopDuration.toInt();

    try {
      if (event.duration < minFlightDuration) {
        throw MyException(S.current.flight_duration_least(minFlightDuration));
      }

      if (event.stopDurations
          .where((d) => d < minStopDuration || d > maxStopDuration)
          .isNotEmpty) {
        throw MyException(S.current
            .stop_duration_condition(minStopDuration, maxStopDuration));
      }

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

      await flightRepo.addFlight(flight);
      emit(FlightAdded());
    } catch (e) {
      emit(NewFlightError(e.toString()));
      Logger.e('NewFlightBloc -> _onAddFlight()', '$e');
    }
  }

  _onInitData(InitData event, Emitter<NewFlightState> emit) async {
    emit(NewFlightLoading());
    AirportRepository airportRepo = Get.find();

    try {
      final airports = await airportRepo.getAirports();
      emit(DataInited(airports));
    } catch (e) {
      emit(NewFlightError(e.toString()));
      Logger.e('NewFlightBloc -> _onInitData()', '$e');
    }
  }
}
