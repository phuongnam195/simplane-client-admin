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

  Future<List<Staff>> getStaffs();

  Future removeStaff(String id);
}

class UserRepositoryImp extends BaseRepositoryImp<User>
    implements UserRepository {
  @override
  Future<User> login(String username, String password) async {
    // return userDummy;

    return User.fromJson(
      await ApiClient(LOGIN).post({
        "username": username,
        "password": password,
      }),
    );
  }

  @override
  Future<User> signup(String fullname, String username, String password) async {
    // return userDummy;

    return User.fromJson(
      await ApiClient(SIGNUP).post({
        "fullname": fullname,
        "username": username,
        "password": password,
        "idAdmin": false,
        "isVerified": true,
      }),
    );
  }

  @override
  Future logout() async {
    // await ApiClient(LOGOUT).post({"commandStyle": 0});
  }

  @override
  Future<List<Staff>> getStaffs() async {
    // Chưa có API
    return staffsDummy;
  }

  @override
  Future removeStaff(String id) async {
    // Chưa có API
    staffsDummy.removeWhere((e) => e.user.id == id);
  }
}
