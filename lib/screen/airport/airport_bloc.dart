//region EVENT

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/util/logger.dart';

abstract class NewAirportEvent {}

class AddAirport extends NewAirportEvent {
  final String codeAirport;
  final String nameAirport;
  final String addressAirport;

  AddAirport(
      {required this.codeAirport,
      required this.nameAirport,
      required this.addressAirport});
}

//endregion

//region STATE
abstract class NewAirportState {}

class NewAirportLoading extends NewAirportState {}

class NewAirportError extends NewAirportState {
  final String error;

  NewAirportError(this.error);
}

class AirportAdded extends NewAirportState {}

//endregion

class NewAirportBloc extends Bloc<NewAirportEvent, NewAirportState> {
  NewAirportBloc() : super(NewAirportLoading()) {
    on<AddAirport>(_onAddAirport);
  }

  _onAddAirport(AddAirport event, Emitter<NewAirportState> emit) async {
    emit(NewAirportLoading());
    // Airport airportRepo = Get.find();

    final airport = Airport(event.codeAirport, event.nameAirport, event.addressAirport);
    fakeDelay;
    try {
      // can tiem kiem trung lap
      airportsDummy.add(airport);
      emit(AirportAdded());
    } catch (e) {
      emit(NewAirportError(e.toString()));
      Logger.e('NewFlightBloc -> _onAddFlight()', '$e');
    }
  }
}
