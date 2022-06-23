import 'package:simplane_client_admin/core/base_repository.dart';
import 'package:simplane_client_admin/dummy_data.dart';
import 'package:simplane_client_admin/model/staff.dart';
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
    // return userDummy;

    Map<String, dynamic> json = await ApiClient(LOGIN).post({
      "username": username,
      "password": password,
    });
    json['accessToken'] = json['token'];
    return User.fromJson(json);
  }

  @override
  Future<User> signup(String fullname, String username, String password) async {
    // return userDummy;

    Map<String, dynamic> json = await ApiClient(SIGNUP).post({
      "fullname": fullname,
      "username": username,
      "password": password,
      "idAdmin": false,
      "isVerified": true,
    });
    json['id'] = '123';
    json['accessToken'] = 'empty';
    return User.fromJson(json);
  }

  @override
  Future logout() async {
    // await ApiClient(LOGOUT).post({"commandStyle": 0});
  }
}
