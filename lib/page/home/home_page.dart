import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/page/login/login_page.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/util/constants.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _navigationSideMenu(),
          Expanded(child: Center(child: Text('HOME'))),
        ],
      ),
    );
  }

  Widget _navigationSideMenu() {
    return Ink(
      color: Colors.grey[100],
      width: 250,
      child: ListView(
        children: [
          Container(
            color: AppColor.primary,
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: AppColor.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    UserManager().getUser()?.fullname ?? 'Fullname',
                    style: AppStyle.subtitle.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    UserManager().getUser()?.username ?? 'Username',
                    style: AppStyle.subtitle.copyWith(color: Colors.white),
                  ),
                ]),
          ),
          ListTile(
            leading: const Icon(Icons.flight),
            title: const Text('Lịch bay'),
            onTap: () {},
            selected: true,
            selectedColor: AppColor.primary,
          ),
          ListTile(
            leading: const Icon(Icons.airplane_ticket_outlined),
            title: const Text('Vé'),
            onTap: () {},
            selected: false,
            selectedColor: AppColor.primary,
          ),
          ListTile(
            leading: const Icon(Icons.summarize_outlined),
            title: const Text('Báo cáo'),
            onTap: () {},
            selected: false,
            selectedColor: AppColor.primary,
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Đăng xuất'),
            onTap: () => _logout(),
            selected: false,
            selectedColor: AppColor.primary,
          ),
        ],
      ),
    );
  }

  _logout() {
    UserRepository().logout();
    UserManager().clearUser();
    Get.offAllNamed(LoginPage.routeName);
  }
}
