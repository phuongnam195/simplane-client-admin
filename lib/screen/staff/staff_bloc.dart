import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/model/staff.dart';
import 'package:simplane_client_admin/repository/report_repository.dart';
import 'package:simplane_client_admin/repository/staff_repository.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

//region EVENT
abstract class StaffEvent {}

class LoadStaffs extends StaffEvent {}

class DeleteStaff extends StaffEvent {
  final String id;

  DeleteStaff(this.id);
}
//endregion

//region STATE
abstract class StaffState {}

class StaffLoading extends StaffState {}

class StaffError extends StaffState {
  final String error;

  StaffError(this.error);
}

class StaffsLoaded extends StaffState {
  final List<Staff> staffs;

  StaffsLoaded(this.staffs);
}

class StaffDeleted extends StaffState {}
//endregion

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  StaffBloc() : super(StaffLoading()) {
    on<LoadStaffs>(_onLoadStaffs);
    on<DeleteStaff>(_onDeleteStaff);
  }

  _onLoadStaffs(LoadStaffs event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    StaffRepository staffRepo = Get.find();
    // List<Staff> result = [];
    try {
      // final users = await userRepo.getStaffs();
      // for (var user in users) {
      //   double ticketCount = await reportRepo.getTotalTicketCount(user.id);
      //   double revenue = await reportRepo.getTotalRevenue(user.id);
      //   result.add(Staff(user, ticketCount, revenue));
      // }
      // emit(StaffsLoaded(result));

      final staffs = await staffRepo.getStaffs();
      emit(StaffsLoaded(staffs));
    } catch (e) {
      emit(StaffError('$e'));
      Logger.e('StaffBloc -> _onLoadStaffs()', '$e');
    }
  }

  _onDeleteStaff(DeleteStaff event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    StaffRepository staffRepo = Get.find();
    try {
      await staffRepo.removeStaff(event.id);
      emit(StaffDeleted());
    } catch (e) {
      emit(StaffError('$e'));
      Logger.e('StaffBloc -> _onDeleteStaff()', '$e');
    }
  }
}
