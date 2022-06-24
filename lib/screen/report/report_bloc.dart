import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/model/airport.dart';
import 'package:simplane_client_admin/model/annual_report.dart';
import 'package:simplane_client_admin/model/flight.dart';
import 'package:simplane_client_admin/repository/airport_repository.dart';
import 'package:simplane_client_admin/repository/flight_repository.dart';
import 'package:simplane_client_admin/repository/report_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';
import 'package:simplane_client_admin/util/print_pdf.dart';

//region EVENT
abstract class ReportEvent {}

class LoadReport extends ReportEvent {
  final int year;

  LoadReport(this.year);
}

class PrintReport extends ReportEvent {
  final AnnualReport report;

  PrintReport(this.report);
}
//endregion

//region STATE
abstract class ReportState {}

class ReportLoading extends ReportState {}

class ReportError extends ReportState {
  final String error;

  ReportError(this.error);
}

class ReportLoaded extends ReportState {
  final AnnualReport report;

  ReportLoaded(this.report);
}
//endregion

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportLoading()) {
    on<LoadReport>(_onLoadReport);
    on<PrintReport>(_onPrintReport);
  }

  _onLoadReport(LoadReport event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    ReportRepository repo = Get.find();

    try {
      final user = UserManager.instance.getUser()!;
      final report =
          await repo.getReport(event.year, user.isAdmin ? null : user.id);
      emit(ReportLoaded(report));
    } catch (e) {
      emit(ReportError(e.toString()));
      Logger.e('ReportBloc -> _onLoadReport()', '$e');
    }
  }

  _onPrintReport(PrintReport event, Emitter<ReportState> emit) async {
    try {
      final pdfFile = await PdfUtils.generateReport(event.report);
      PdfUtils.openFile(pdfFile);
    } catch (e) {
      emit(ReportError(e.toString()));
      Logger.e('ReportBloc -> _onPrintReport()', '$e');
    }
  }
}
