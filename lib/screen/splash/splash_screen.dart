import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/screen/staff/home/home_screen.dart';
import 'package:simplane_client_admin/screen/auth/auth_screen.dart';
import 'package:simplane_client_admin/screen/splash/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _splashBloc = SplashBloc();
    _splashBloc.add(CheckSession());
    return BlocListener<SplashBloc, SplashState>(
      bloc: _splashBloc,
      listener: (context, state) {
        if (state is HasNotLoggedIn) {
          Get.offAllNamed(AuthScreen.routeName);
        } else if (state is DataLoaded) {
          Get.offAllNamed(HomeScreen.routeName);
        }
      },
      child: Container(
        color: Colors.white,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
