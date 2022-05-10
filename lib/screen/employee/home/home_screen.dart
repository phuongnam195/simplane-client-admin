import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/injection.dart' as di;
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/screen/auth/auth_screen.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/screen/employee/home/home_bloc.dart';
import 'package:simplane_client_admin/util/constants.dart';

final homeBloc = HomeBloc();

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _navigationSideMenu(),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
                bloc: homeBloc,
                buildWhen: (previous, current) =>
                    current is PageNavigated || current is HomeLoading,
                builder: (context, state) {
                  if (state is PageNavigated) {
                    return state.page;
                  } else if (state is HomeLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                }),
          ),
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
                    UserManager.instance.getUser()?.fullname ?? 'Fullname',
                    style: AppStyle.subtitle.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    UserManager.instance.getUser()?.username ?? 'Username',
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
    UserRepository repo = Get.find();
    repo.logout();
    UserManager.instance.clearUser();
    Get.offAllNamed(AuthScreen.routeName);
  }
}
