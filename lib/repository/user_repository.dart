import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/user.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

abstract class UserRepository extends BaseRepository<User> {
  Future<User> login(String username, String password);

  Future<User> signup(String fullname, String username, String password);

  Future logout();
}

class UserRepositoryImp extends BaseRepositoryImp<User>
    implements UserRepository {
  @override
  Future<User> login(String username, String password) async {
    return User.fromJson(
      await ApiClient(LOGIN).post({
        "username": username,
        "password": password,
      }),
    );
  }

  @override
  Future<User> signup(String fullname, String username, String password) async {
    return User.fromJson(
      await ApiClient(SIGNUP).post({
        "fullname": fullname,
        "username": username,
        "password": password,
      }),
    );
  }

  @override
  Future logout() async {
    await ApiClient(LOGOUT).post({"commandStyle": 0});
  }
}
