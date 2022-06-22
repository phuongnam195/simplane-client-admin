import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/core/user_manager.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/screen/auth/auth_screen.dart';
import 'package:simplane_client_admin/screen/home/home_bloc.dart';
import 'package:simplane_client_admin/screen/flight/flight_page.dart';
import 'package:simplane_client_admin/screen/report/report_page.dart';
import 'package:simplane_client_admin/screen/staff/staff_page.dart';
import 'package:simplane_client_admin/screen/ticket/ticket_page.dart';
import 'package:simplane_client_admin/util/constants.dart';

final homeBloc = HomeBloc();

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currPage = FlightPage.pageName;

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
                switch (currPage) {
                  case FlightPage.pageName:
                    return const FlightPage();
                  case TicketPage.pageName:
                    return const TicketPage();
                  case StaffPage.pageName:
                    return const StaffPage();
                  case ReportPage.pageName:
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
              if (currPage == FlightPage.pageName) return;
              setState(() {
                currPage = FlightPage.pageName;
              });
            },
            selected: currPage == FlightPage.pageName,
            selectedColor: AppColor.primary,
          ),
          if (UserManager.instance.getUser()?.isAdmin == false)
            ListTile(
              leading: const Icon(Icons.airplane_ticket_outlined),
              title: Text(S.current.ticket),
              onTap: () {
                if (currPage == TicketPage.pageName) return;
                setState(() {
                  currPage = TicketPage.pageName;
                });
              },
              selected: currPage == TicketPage.pageName,
              selectedColor: AppColor.primary,
            ),
          if (UserManager.instance.getUser()?.isAdmin == true)
            ListTile(
              leading: const Icon(Icons.group_outlined),
              title: Text(S.current.staff),
              onTap: () {
                if (currPage == StaffPage.pageName) return;
                setState(() {
                  currPage = StaffPage.pageName;
                });
              },
              selected: currPage == StaffPage.pageName,
              selectedColor: AppColor.primary,
            ),
          ListTile(
            leading: const Icon(Icons.summarize_outlined),
            title: Text(S.current.report),
            onTap: () {
              if (currPage == ReportPage.pageName) return;
              setState(() {
                currPage = ReportPage.pageName;
              });
            },
            selected: currPage == ReportPage.pageName,
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
    homeBloc.add(Logout());
    Get.offAllNamed(AuthScreen.routeName);
  }
}
