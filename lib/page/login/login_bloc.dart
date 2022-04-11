//region EVENT
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplane_client_admin/core/setting.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/model/user.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

abstract class LoginEvent {}

class Login extends LoginEvent {
  final String username;
  final String password;

  Login(this.username, this.password);
}
//endregion

//region STATE
abstract class LoginState {}

class LoginInit extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
//endregion

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInit()) {
    on<Login>(_onLogin);
  }

  _onLogin(Login event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      // TODO: Chưa có API
      // final user = await UserRepository().login(event.username, event.password);
      // await Setting().saveUserInfo(user);
      // NetworkBase.instance.addApiHeaders({
      //   'accessToken': UserManager().accessToken(),
      // });
      UserManager()
          .setUser(const User(123, 'nam1952001', 'Đặng Phương Nam', ''));
      emit(LoginSuccess());
    } catch (e) {
      Logger.e('LoginBloc -> _mapLoginToState()', '$e');
      emit(LoginFailure('$e'));
    }
  }
}
