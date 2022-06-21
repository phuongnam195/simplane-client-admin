import 'package:simplane_client_admin/core/setting.dart';
import 'package:simplane_client_admin/model/user.dart';

class UserManager {
  static final UserManager instance = UserManager._internal();
  UserManager._internal();

  User? _user;

  String accessToken() {
    if (_user != null) {
      return _user!.token;
    }
    return "";
  }

  User? getUser() => _user;

  setUser(User user) => _user = user;

  clearUser() => _user = null;

  Future<User?> loadUser() async {
    _user ??= await Setting().getUserInfo();
    return _user;
  }
}
