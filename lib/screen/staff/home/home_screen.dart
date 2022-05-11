import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/injection.dart' as di;
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/screen/auth/auth_screen.dart';
import 'package:simplane_client_admin/repository/user_repository.dart';
import 'package:simplane_client_admin/screen/staff/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/staff/flight/flight_page.dart';
import 'package:simplane_client_admin/screen/staff/report/report_page.dart';
import 'package:simplane_client_admin/screen/staff/ticket/ticket_page.dart';
import 'package:simplane_client_admin/util/constants.dart';

final homeBloc = HomeBloc();

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curPageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _navigationSideMenu(),
          Expanded(
            child: Builder(
              builder: (context) {
                switch (curPageIdx) {
                  case 0:
                    return const FlightPage();
                  case 1:
                    return const TicketPage();
                  case 2:
                    return const ReportPage();
                  default:
                    return Container();
                }
              },
            ),
          )
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
            title: Text(S.current.flight_schedule),
            onTap: () {
              if (curPageIdx == 0) return;
              setState(() {
                curPageIdx = 0;
              });
            },
            selected: curPageIdx == 0,
            selectedColor: AppColor.primary,
          ),
          ListTile(
            leading: const Icon(Icons.airplane_ticket_outlined),
            title: Text(S.current.ticket),
            onTap: () {
              if (curPageIdx == 1) return;
              setState(() {
                curPageIdx = 1;
              });
            },
            selected: curPageIdx == 1,
            selectedColor: AppColor.primary,
          ),
          ListTile(
            leading: const Icon(Icons.summarize_outlined),
            title: Text(S.current.report),
            onTap: () {
              if (curPageIdx == 2) return;
              setState(() {
                curPageIdx = 2;
              });
            },
            selected: curPageIdx == 2,
            selectedColor: AppColor.primary,
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: Text(S.current.logout),
            onTap: () => _logout(),
            selected: false,
            selectedColor: AppColor.primary,
          ),
        ],
      ),
    );
  }

  _logout() async {
    UserRepository repo = Get.find();
    repo.logout();
    UserManager.instance.clearUser();
    Get.offAllNamed(AuthScreen.routeName);
  }
}
