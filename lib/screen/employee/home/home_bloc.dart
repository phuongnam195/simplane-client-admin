//region EVENT
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/injection.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/screen/employee/home/page/flight_page.dart';
import 'package:simplane_client_admin/util/logger.dart';

import 'page/report_page.dart';
import 'page/ticket_page.dart';

abstract class HomeEvent {}

class NavigatePage extends HomeEvent {
  final String pageName;

  NavigatePage(this.pageName);
}

class LoadFlights extends HomeEvent {
  final DateTime fromDate;
  final DateTime toDate;

  LoadFlights(this.fromDate, this.toDate);
}
//endregion

//region STATE
abstract class HomeState {}

class PageNavigated extends HomeState {
  final Widget page;

  PageNavigated(this.page);
}

class HomeLoading extends HomeState {}

class DataLoading extends HomeState {}

class FlightsLoaded extends HomeState {
  final List<Flight> flights;

  FlightsLoaded(this.flights);
}

class LoadDataFailed extends HomeState {
  final String error;

  LoadDataFailed(this.error);
}
//endregion

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(PageNavigated(const FlightPage())) {
    on<NavigatePage>(_onNavigate);
    on<LoadFlights>(_onLoadFlights);
  }

  FlightPage? _flightPage;
  TicketPage? _ticketPage;
  ReportPage? _reportPage;

  _onNavigate(NavigatePage event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    switch (event.pageName) {
      case FlightPage.pageName:
        _flightPage ??= const FlightPage();
        emit(PageNavigated(_flightPage!));
        break;
      case TicketPage.pageName:
        _ticketPage ??= const TicketPage();
        emit(PageNavigated(_ticketPage!));
        break;
      case ReportPage.pageName:
        _reportPage ??= const ReportPage();
        emit(PageNavigated(_reportPage!));
        break;
    }
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
}
