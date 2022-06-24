//region EVENT
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/setting.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';
import 'package:simplane_client_admin/util/logger.dart';

abstract class SplashEvent {}

class LoadSetting extends SplashEvent {}

class CheckSession extends SplashEvent {}
//endregion

//region STATE
abstract class SplashState {}

class SplashLoading extends SplashState {}

class HasNotLoggedIn extends SplashState {}

class SettingLoaded extends SplashState {}

class DataLoaded extends SplashState {}

class SplashError extends SplashState {
  final String error;

  SplashError(this.error);
}
//endregion

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashLoading()) {
    on<LoadSetting>(_onLoadSetting);
    on<CheckSession>(_onCheckSession);
  }

  _onLoadSetting(LoadSetting event, Emitter<SplashState> emit) async {
    try {
      final languageCode = await Setting().getLanguage();
      S.load(Locale(languageCode));
    } catch (e) {
      Logger.e('SplashBloc -> _onLoadSetting()', '$e');
      emit(SplashError('$e'));
    }
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
      emit(SplashError('$e'));
    }
  }
}
