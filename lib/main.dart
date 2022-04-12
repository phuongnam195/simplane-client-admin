import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/generated/l10n.dart';

import 'page/home/home_page.dart';
import 'page/auth/auth_page.dart';
import 'page/splash/splash_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simplane',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.routeName,
      getPages: [
        GetPage(name: SplashPage.routeName, page: () => const SplashPage()),
        GetPage(name: AuthPage.routeName, page: () => const AuthPage()),
        GetPage(name: HomePage.routeName, page: () => const HomePage()),
      ],
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
