import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/screen/home/home_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';

import 'auth_bloc.dart';
import 'login_card.dart';
import 'signup_card.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final imageUrl =
      'https://images.unsplash.com/photo-1559268950-2d7ceb2efa3a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=nick-morales-BwYcH78rcpI-unsplash.jpg&w=800';

  final _authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listenWhen: (prev, curr) =>
          curr is AuthLoading ||
          curr is AuthError ||
          curr is AuthSuccess ||
          curr is LanguageSwitched,
      listener: (ctx, state) {
        EasyLoading.dismiss();
        if (state is AuthLoading) {
          EasyLoading.show();
        } else if (state is AuthError) {
          EasyLoading.showError(state.error);
        } else if (state is AuthSuccess) {
          Get.offAllNamed(HomeScreen.routeName);
        } else if (state is LanguageSwitched) {
          setState(() {});
        }
      },
      child: Scaffold(
          body: Row(
        children: [
          SizedBox(
            height: screenWidth * 0.65,
            width: screenWidth * 0.6,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: screenWidth * 0.65,
              width: screenWidth * 0.6,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 100,
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: const EdgeInsets.all(20),
                    child: TextButton.icon(
                      label: Text(
                        S.current.language,
                        style: AppStyle.title.copyWith(fontSize: 17),
                      ),
                      icon: const Icon(Icons.translate, size: 22),
                      onPressed: () => _authBloc.add(SwitchLanguage()),
                      style: TextButton.styleFrom(primary: AppColor.secondary),
                    ),
                  ),
                ),
                BlocBuilder(
                    bloc: _authBloc,
                    buildWhen: (previous, current) => current is SetAuthType,
                    builder: (context, state) {
                      if (state is SetAuthType) {
                        switch (state.type) {
                          case AuthType.login:
                            return LoginCard(_authBloc);
                          case AuthType.signup:
                            return SignUpCard(_authBloc);
                        }
                      }
                      return Container();
                    }),
                const SizedBox(height: 100),
              ],
            ),
          )
        ],
      )),
    );
  }
}
