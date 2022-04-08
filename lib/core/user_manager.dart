import 'package:simplane_client_admin/core/setting.dart';
import 'package:simplane_client_admin/model/user.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() {
    return _instance;
  }
  UserManager._internal();

  User? _user;

  String accessToken() {
    if (_user != null) {
      return _user!.accessToken;
    }
    return "";
  }

  User? getUser() => _user;

  clearUser() => _user = null;

  Future<User?> loadUser() async {
    _user ??= await Setting().getUserInfo();
    return _user;
  }
}
