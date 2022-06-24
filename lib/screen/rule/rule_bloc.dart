import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/model/rule.dart';
import 'package:simplane_client_admin/repository/airport_repository.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/repository/report_repository.dart';
import 'package:simplane_client_admin/repository/rule_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';
import 'package:simplane_client_admin/util/print_pdf.dart';

//region EVENT
abstract class RuleEvent {}

class LoadRule extends RuleEvent {}

class UpdateRule extends RuleEvent {
  final double minFlightDuration;
  final double maxMiddleAirport;
  final double minStopDuration;
  final double maxStopDuration;
  final double latestTimeBooking;
  final double latestTimeCancelBooking;

  UpdateRule(
      this.minFlightDuration,
      this.maxMiddleAirport,
      this.minStopDuration,
      this.maxStopDuration,
      this.latestTimeBooking,
      this.latestTimeCancelBooking); // minute

}
//endregion

//region STATE
abstract class RuleState {}

class RuleLoading extends RuleState {}

class RuleError extends RuleState {
  final String error;

  RuleError(this.error);
}

class RuleLoaded extends RuleState {
  final Rule rule;

  RuleLoaded(this.rule);
}

class RuleUpdated extends RuleState {
  final Rule rule;

  RuleUpdated(this.rule);
}
//endregion

class RuleBloc extends Bloc<RuleEvent, RuleState> {
  RuleBloc() : super(RuleLoading()) {
    on<LoadRule>(_onLoadRule);
    on<UpdateRule>(_onUpdateRule);
  }

  _onLoadRule(LoadRule event, Emitter<RuleState> emit) async {
    emit(RuleLoading());
    try {
      final rule = await RuleManager.instance.load();
      emit(RuleLoaded(rule!));
    } catch (e) {
      emit(RuleError(e.toString()));
      Logger.e('ReportBloc -> _onLoadRule()', '$e');
    }
  }

  _onUpdateRule(UpdateRule event, Emitter<RuleState> emit) async {
    emit(RuleLoading());
    final newRule = Rule(
      minFlightDuration: event.minFlightDuration,
      maxMiddleAirport: event.maxMiddleAirport,
      minStopDuration: event.minStopDuration,
      maxStopDuration: event.maxStopDuration,
      latestTimeBooking: event.latestTimeBooking,
      latestTimeCancelBooking: event.latestTimeCancelBooking,
    );

    try {
      final resRule = (await RuleManager.instance.updateRule(newRule))!;
      emit(RuleUpdated(resRule));
    } catch (e) {
      emit(RuleError(e.toString()));
      Logger.e('RuleBloc -> _onUpdateRule()', '$e');
    }
  }
}
