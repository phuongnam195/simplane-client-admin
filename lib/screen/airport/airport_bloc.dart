import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/repository/airport_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

//region EVENT
abstract class AirportEvent {}

class LoadAirports extends AirportEvent {}

class AddAirport extends AirportEvent {
  final Airport airport;

  AddAirport(this.airport);
}

class UpdateAirport extends AirportEvent {
  final Airport airport;

  UpdateAirport(this.airport);
}

class DeleteAirport extends AirportEvent {
  final Airport airport;

  DeleteAirport(this.airport);
}
//endregion

//region STATE
abstract class AirportState {}

class AirportLoading extends AirportState {}

class AirportsLoaded extends AirportState {
  final List<Airport> airports;

  AirportsLoaded(this.airports);
}

class AirportAdded extends AirportState {}

class AirportUpdated extends AirportState {}

class AirportDeleted extends AirportState {}

class AirportError extends AirportState {
  final String error;

  AirportError(this.error);
}
//endregion

class AirportBloc extends Bloc<AirportEvent, AirportState> {
  AirportBloc() : super(AirportLoading()) {
    on<LoadAirports>(_onLoadAirport);
    on<AddAirport>(_onAddAirport);
    on<UpdateAirport>(_onUpdateAirport);
    on<DeleteAirport>(_onDeleteAirport);
  }

  _onLoadAirport(LoadAirports event, Emitter<AirportState> emit) async {
    emit(AirportLoading());
    AirportRepository repo = Get.find();
    try {
      final airports = await repo.getAirports();
      emit(AirportsLoaded(airports));
    } catch (e) {
      emit(AirportError(e.toString()));
      Logger.e('AirportBloc -> _onLoadAirports()', '$e');
    }
  }

  _onAddAirport(AddAirport event, Emitter<AirportState> emit) async {
    emit(AirportLoading());
    AirportRepository repo = Get.find();
    try {
      await repo.addAirport(event.airport);
      emit(AirportUpdated());
    } catch (e) {
      emit(AirportError(e.toString()));
      Logger.e('AirportBloc -> _onAddAirport()', '$e');
    }
  }

  _onUpdateAirport(UpdateAirport event, Emitter<AirportState> emit) async {
    emit(AirportLoading());
    AirportRepository repo = Get.find();
    try {
      await repo.updateAirport(event.airport);
      emit(AirportUpdated());
    } catch (e) {
      emit(AirportError(e.toString()));
      Logger.e('AirportBloc -> _onUpdateAirport()', '$e');
    }
  }

  _onDeleteAirport(DeleteAirport event, Emitter<AirportState> emit) async {
    emit(AirportLoading());
    AirportRepository repo = Get.find();
    try {
      await repo.deleteAirport(event.airport);
      emit(AirportDeleted());
    } catch (e) {
      emit(AirportError(e.toString()));
      Logger.e('AirportBloc -> _onDeleteAirport()', '$e');
    }
  }
}
