import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/injection.dart' as di;
import 'screen/employee/home/home_screen.dart';
import 'screen/auth/auth_screen.dart';
import 'screen/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.configureDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('vi_VN');
    return GetMaterialApp(
      title: 'Simplane',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      getPages: [
        GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
        GetPage(name: AuthScreen.routeName, page: () => const AuthScreen()),
        GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
      ],
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
