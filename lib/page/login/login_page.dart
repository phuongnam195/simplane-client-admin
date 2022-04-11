import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/page/home/home_page.dart';
import 'package:simplane_client_admin/page/login/login_bloc.dart';
import 'package:simplane_client_admin/util/constants.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://images.unsplash.com/photo-1559268950-2d7ceb2efa3a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&dl=nick-morales-BwYcH78rcpI-unsplash.jpg&w=800';

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
        const Expanded(child: Center(child: LoginCard())),
      ],
    ));
  }
}

class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginBloc = LoginBloc();

  _login() =>
      _loginBloc.add(Login(_usernameController.text, _passwordController.text));

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginSuccess) {
          Get.offAllNamed(HomePage.routeName);
        }
      },
      child: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(MdiIcons.key),
              ),
              onSubmitted: (_) => _login(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    S.current.register,
                  ),
                  style: TextButton.styleFrom(
                    primary: AppColor.description,
                    textStyle: const TextStyle(fontSize: 15),
                    padding: const EdgeInsets.all(20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _login(),
                  child: Text(S.current.sign_in),
                  style: ElevatedButton.styleFrom(
                    primary: AppColor.primary,
                    padding: const EdgeInsets.all(25),
                    textStyle: const TextStyle(fontSize: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
