import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_bloc.dart';
import 'login_card.dart';
import 'signup_card.dart';

class AuthPage extends StatelessWidget {
  static const routeName = '/auth';

  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://images.unsplash.com/photo-1559268950-2d7ceb2efa3a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=nick-morales-BwYcH78rcpI-unsplash.jpg&w=800';

    final _authBloc = AuthBloc();

    return Scaffold(
        body: Row(
      children: [
        SizedBox(
          height: 800,
          width: 700,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: 800,
            width: 700,
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
    ));
  }
}
