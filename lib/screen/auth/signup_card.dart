import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:simplane_client_admin/util/constants.dart';

import 'auth_bloc.dart';

class SignUpCard extends StatefulWidget {
  const SignUpCard(this.authBloc, {Key? key}) : super(key: key);

  final AuthBloc authBloc;

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  _signUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.authBloc.add(SignUp(
      _fullnameController.text,
      _usernameController.text,
      _passwordController.text,
      _retypePasswordController.text,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _fullnameController,
              decoration: InputDecoration(
                labelText: S.current.fullname,
                prefixIcon: const Icon(Icons.person_pin_rounded),
              ),
              validator: (_) => _validFullname(),
            ),
            const SizedBox(height: 30),
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
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _retypePasswordController,
              decoration: InputDecoration(
                labelText: S.current.retype_password,
                prefixIcon: const Icon(MdiIcons.key),
              ),
              obscureText: true,
              validator: (_) => _validRetypePassword(),
              onFieldSubmitted: (_) => _signUp(),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  iconSize: 22,
                  onPressed: () =>
                      widget.authBloc.add(SwitchTo(AuthType.login)),
                  color: AppColor.description,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _signUp(),
                  child: Text(S.current.register),
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

  String? _validFullname() {
    if (_fullnameController.text.isEmpty) {
      return S.current.not_empty;
    }
    return null;
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

  String? _validRetypePassword() {
    if (_retypePasswordController.text.isEmpty) {
      return S.current.not_empty;
    }
    if (_retypePasswordController.text.compareTo(_passwordController.text) !=
        0) {
      return S.current.retype_password_not_match;
    }
    return null;
  }
}
