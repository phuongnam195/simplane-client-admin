//region EVENT
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

abstract class SplashEvent {}

class CheckSession extends SplashEvent {}
//endregion

//region STATE
abstract class SplashState {}

class SplashLoading extends SplashState {}

class HasNotLoggedIn extends SplashState {}

class DataLoaded extends SplashState {}

class SplashNotLoaded extends SplashState {
  final String error;

  SplashNotLoaded(this.error);
}
//endregion

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<CheckSession>(_onCheckSession);
  }

  _onCheckSession(CheckSession event, Emitter<SplashState> emit) async {
    final user = await UserManager().loadUser();
    if (user == null) {
      emit(HasNotLoggedIn());
      return;
    }
    NetworkBase.instance.addApiHeaders({
      'accessToken': UserManager().accessToken(),
    });
    try {
      // TODO: Load data
      Future.delayed(const Duration(seconds: 2));
      // emit(DataLoaded());
    } catch (e) {
      Logger.e('SplashBloc -> _mapCheckSessionToState()', '$e');
      emit(SplashNotLoaded('$e'));
    }
  }

  Stream<SplashState> _mapCheckSessionToState() async* {
    final user = await UserManager().loadUser();
    if (user == null) {
      yield HasNotLoggedIn();
      return;
    }
    NetworkBase.instance.addApiHeaders({
      'accessToken': UserManager().accessToken(),
    });
    try {
      // TODO: Load data
      Future.delayed(const Duration(seconds: 2));
      // yield DataLoaded();
    } catch (e) {
      Logger.e('SplashBloc -> _mapCheckSessionToState()', '$e');
      yield SplashNotLoaded('$e');
    }
  }
}