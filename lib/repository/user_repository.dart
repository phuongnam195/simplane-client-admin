import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/model/user.dart';
import 'package:simplane_client_admin/network/api_path.dart';
import 'package:simplane_client_admin/network/base/api_client.dart';

class UserRepository extends BaseRepositoryImp<User> {
  Future<User> login(String username, String password) async {
    return User.fromJson(
      await ApiClient(LOGIN).post({
        "username": username,
        "password": password,
      }),
    );
  }

  Future logout() async {
    await ApiClient(LOGOUT).post({"commandStyle": 0});
  }
}
