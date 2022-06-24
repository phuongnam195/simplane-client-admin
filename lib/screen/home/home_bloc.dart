import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/setting.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

//region EVENT
abstract class HomeEvent {}

class Logout extends HomeEvent {}
//endregion

//region STATE
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeEror extends HomeState {
  final String error;

  HomeEror(this.error);
}
//endregion

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<Logout>(_onLogout);
  }

  _onLogout(Logout event, Emitter<HomeState> emit) async {
    UserRepository repo = Get.find();
    try {
      await repo.logout();
      UserManager.instance.clearUser();
      await Setting().clearAllData();
    } catch (e) {
      emit(HomeEror(e.toString()));
      Logger.e('HomeBloc -> _onLogout()', '$e');
    }
  }
}
