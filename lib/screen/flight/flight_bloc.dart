import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

//region EVENT
abstract class FlightEvent {}

class LoadFlights extends FlightEvent {
  final DateTime fromDate;
  final DateTime toDate;

  LoadFlights(this.fromDate, this.toDate);
}

class DeleteFlight extends FlightEvent {
  final String id;

  DeleteFlight(this.id);
}
//endregion

//region STATE
abstract class FlightState {}

class FlightLoading extends FlightState {}

class FlightsLoaded extends FlightState {
  final List<Flight> flights;

  FlightsLoaded(this.flights);
}

class FlightDeleted extends FlightState {}

class FlightError extends FlightState {
  final String error;

  FlightError(this.error);
}
//endregion

class FlightBloc extends Bloc<FlightEvent, FlightState> {
  FlightBloc() : super(FlightLoading()) {
    on<LoadFlights>(_onLoadFlights);
    on<DeleteFlight>(_onDeleteFlight);
  }

  _onLoadFlights(LoadFlights event, Emitter<FlightState> emit) async {
    emit(FlightLoading());
    FlightRepository repo = Get.find();
    try {
      final flights =
          await repo.getFlights(fromDate: event.fromDate, toDate: event.toDate);
      emit(FlightsLoaded(flights));
    } catch (e) {
      emit(FlightError(e.toString()));
      Logger.e('FlightBloc -> _onLoadFlights()', '$e');
    }
  }

  _onDeleteFlight(DeleteFlight event, Emitter<FlightState> emit) async {
    emit(FlightLoading());
    FlightRepository repo = Get.find();
    try {
      await repo.deleteFlight(event.id);
      emit(FlightDeleted());
    } catch (e) {
      emit(FlightError(e.toString()));
      Logger.e('FlightBloc -> _onDeleteFlight()', '$e');
    }
  }
}
