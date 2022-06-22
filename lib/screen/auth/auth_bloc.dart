//region EVENT
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/rule_manager.dart';
import 'package:simplane_client_admin/core/setting.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/network/base/network_base.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/util/logger.dart';
import 'package:simplane_client_admin/util/my_exception.dart';

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

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
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
      UserRepository repo = Get.find();
      final user = await repo.login(event.username, event.password);
      await Setting().saveUserInfo(user);
      NetworkBase.instance.addApiHeaders({
        'accessToken': UserManager.instance.accessToken(),
      });
      UserManager.instance.setUser(user);
      await RuleManager.instance.load();
      emit(AuthSuccess());
    } catch (e) {
      Logger.e('AuthBloc -> _onLogin()', '$e');
      emit(AuthError('$e'));
    }
  }

  _onSignUp(SignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      if (event.password != event.retypePassword) {
        throw MyException(S.current.retype_password_not_match);
      }
      UserRepository repo = Get.find();
      final user =
          await repo.signup(event.fullname, event.username, event.password);
      await Setting().saveUserInfo(user);
      NetworkBase.instance.addApiHeaders({
        'accessToken': UserManager.instance.accessToken(),
      });
      UserManager.instance.setUser(user);
      await RuleManager.instance.load();
      emit(AuthSuccess());
    } catch (e) {
      Logger.e('AuthBloc -> _onSignUp()', '$e');
      emit(AuthError('$e'));
    }
  }
}
