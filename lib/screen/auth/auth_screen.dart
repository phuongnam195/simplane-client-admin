import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/screen/home/home_screen.dart';

import 'auth_bloc.dart';
import 'login_card.dart';
import 'signup_card.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://images.unsplash.com/photo-1559268950-2d7ceb2efa3a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=nick-morales-BwYcH78rcpI-unsplash.jpg&w=800';

    final _authBloc = AuthBloc();
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listenWhen: (prev, curr) =>
          curr is AuthLoading || curr is AuthError || curr is AuthSuccess,
      listener: (ctx, state) {
        EasyLoading.dismiss();
        if (state is AuthLoading) {
          EasyLoading.show();
        } else if (state is AuthError) {
          EasyLoading.showError(state.error);
        } else if (state is AuthSuccess) {
          Get.offAllNamed(HomeScreen.routeName);
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
            child: Center(
              child: BlocBuilder(
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
            ),
          )
        ],
      )),
    );
  }
}
