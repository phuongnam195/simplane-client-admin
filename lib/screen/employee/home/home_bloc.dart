//region EVENT
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/injection.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/model/ticket.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/repository/ticket_repository.dart';
import 'package:simplane_client_admin/screen/employee/home/page/flight_page.dart';
import 'package:simplane_client_admin/util/logger.dart';

import 'page/report_page.dart';
import 'page/ticket_page.dart';

abstract class HomeEvent {}

class LoadFlights extends HomeEvent {
  final DateTime fromDate;
  final DateTime toDate;

  LoadFlights(this.fromDate, this.toDate);
}

class LoadTickets extends HomeEvent {
  final DateTime fromDate;
  final DateTime toDate;
  final Map<String, dynamic> extraQuery;

  LoadTickets(this.fromDate, this.toDate, this.extraQuery);
}
//endregion

//region STATE
abstract class HomeState {}

class HomeLoading extends HomeState {}

class DataLoading extends HomeState {}

class FlightsLoaded extends HomeState {
  final List<Flight> flights;

  FlightsLoaded(this.flights);
}

class TicketsLoaded extends HomeState {
  final List<Ticket> tickets;

  TicketsLoaded(this.tickets);
}

class LoadDataFailed extends HomeState {
  final String error;

  LoadDataFailed(this.error);
}
//endregion

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadFlights>(_onLoadFlights);
    on<LoadTickets>(_onLoadTickets);
  }

  _onLoadFlights(LoadFlights event, Emitter<HomeState> emit) async {
    emit(DataLoading());
    FlightRepository repo = Get.find();
    try {
      final flights =
          await repo.getFlights(fromDate: event.fromDate, toDate: event.toDate);
      emit(FlightsLoaded(flights));
    } catch (e) {
      emit(LoadDataFailed(e.toString()));
      Logger.e('HomeBloc -> _onLoadFlights()', e);
    }
  }

  _onLoadTickets(LoadTickets event, Emitter<HomeState> emit) async {
    emit(DataLoading());
    TicketRepository repo = Get.find();
    try {
      final tickets = await repo.getTickets(
          fromDate: event.fromDate,
          toDate: event.toDate,
          extraQuery: event.extraQuery);
      emit(TicketsLoaded(tickets));
    } catch (e) {
      emit(LoadDataFailed(e.toString()));
      Logger.e('HomeBloc -> _onLoadTickets()', e);
    }
  }
}
