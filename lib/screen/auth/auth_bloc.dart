//region EVENT
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/setting.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/model/user.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';

abstract class AuthEvent {}

class Login extends AuthEvent {
  final String username;
  final String password;

  Login(this.username, this.password);
}

class SignUp extends AuthEvent {
  final String fullname;
  final String username;
  final String password;
  final String retypePassword;

  SignUp(this.fullname, this.username, this.password, this.retypePassword);
}

enum AuthType { login, signup }

class SwitchTo extends AuthEvent {
  final AuthType type;

  SwitchTo(this.type);
}
//endregion

//region STATE
abstract class AuthState {}

class AuthInit extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class SignUpSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

class SetAuthType extends AuthState {
  final AuthType type;

  SetAuthType(this.type);
}
//endregion

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(SetAuthType(AuthType.login)) {
    on<SwitchTo>(((event, emit) => emit(SetAuthType(event.type))));
    on<Login>(_onLogin);
    on<SignUp>(_onSignUp);
  }

  _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // TODO: Chưa có API
      // final user = await UserRepository().login(event.username, event.password);
      // await Setting().saveUserInfo(user);
      // NetworkBase.instance.addApiHeaders({
      //   'accessToken': UserManager().accessToken(),
      // });
      UserManager.instance.setUser(userDummy);
      await RuleManager.instance.load();
      emit(LoginSuccess());
    } catch (e) {
      Logger.e('AuthBloc -> _onLogin()', '$e');
      emit(AuthFailure('$e'));
    }
  }

  _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // TODO: Chưa có API
      // final user = await UserRepository().signup(event.fullname, event.username, event.password);
      // await Setting().saveUserInfo(user);
      // NetworkBase.instance.addApiHeaders({
      //   'accessToken': UserManager().accessToken(),
      // });
      UserManager.instance.setUser(userDummy);
      await RuleManager.instance.load();
      emit(SignUpSuccess());
    } catch (e) {
      Logger.e('AuthBloc -> _onSignUp()', '$e');
      emit(AuthFailure('$e'));
    }
  }
}
