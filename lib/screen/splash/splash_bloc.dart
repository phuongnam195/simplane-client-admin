//region EVENT
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';
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
    final user = await UserManager.instance.loadUser();
    if (user == null) {
      emit(HasNotLoggedIn());
      return;
    }
    NetworkBase.instance.addApiHeaders({
      'accessToken': UserManager.instance.accessToken(),
    });
    try {
      await RuleManager.instance.load();
      emit(DataLoaded());
    } catch (e) {
      Logger.e('SplashBloc -> _onCheckSession()', '$e');
      emit(SplashNotLoaded('$e'));
    }
  }
}
