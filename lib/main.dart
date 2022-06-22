import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:simplane_client_admin/generated/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simplane_client_admin/screen/booking/booking_screen.dart';
import 'package:simplane_client_admin/screen/flight/new_flight_screen.dart';

import 'core/injection.dart' as di;
import 'screen/home/home_screen.dart';
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
        GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
        GetPage(
            name: BookingScreen.routeName, page: () => const BookingScreen()),
        GetPage(
            name: NewFlightScreen.routeName,
            page: () => const NewFlightScreen()),
      ],
      builder: EasyLoading.init(),
      localizationsDelegates: const [
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
