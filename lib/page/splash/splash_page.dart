import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/page/home/home_page.dart';
import 'package:simplane_client_admin/page/login/login_page.dart';
import 'package:simplane_client_admin/page/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _splashBloc = SplashBloc();
    _splashBloc.add(CheckSession());
    return BlocListener<SplashBloc, SplashState>(
      bloc: _splashBloc,
      listener: (context, state) {
        if (state is HasNotLoggedIn) {
          Get.offAllNamed(LoginPage.routeName);
        } else if (state is DataLoaded) {
          Get.offAllNamed(HomePage.routeName);
        }
      },
      child: Container(
        color: Colors.white,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
