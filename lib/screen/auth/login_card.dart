import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/screen/staff/home/home_screen.dart';
import 'package:simplane_client_admin/util/constants.dart';

import 'auth_bloc.dart';

class LoginCard extends StatefulWidget {
  const LoginCard(this.authBloc, {Key? key}) : super(key: key);

  final AuthBloc authBloc;

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.authBloc
        .add(Login(_usernameController.text, _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<AuthBloc, AuthState>(
      bloc: widget.authBloc,
      listener: (context, state) {
        if (state is LoginSuccess) {
          Get.offAllNamed(HomeScreen.routeName);
        }
      },
      child: SizedBox(
        width: screenWidth * 0.35,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: S.current.username,
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (_) => _validUsername(),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: S.current.password,
                  prefixIcon: const Icon(MdiIcons.key),
                ),
                obscureText: true,
                validator: (_) => _validPassword(),
                onFieldSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        widget.authBloc.add(SwitchTo(AuthType.signup)),
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
      ),
    );
  }

  String? _validUsername() {
    if (_usernameController.text.isEmpty) {
      return S.current.not_empty;
    }
    return null;
  }

  String? _validPassword() {
    if (_passwordController.text.isEmpty) {
      return S.current.not_empty;
    }
    return null;
  }
}
