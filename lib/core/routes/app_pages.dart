import 'package:flutter_shop_app/features/main_pages.dart';
import 'package:flutter_shop_app/features/user/views/sign_in_page.dart';
import 'package:get/get.dart';

import '../../features/settings/views/settings_page.dart';
import '../../features/splash/views/splash_page.dart';
import 'app_bindings.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.signIn;
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const AuthPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () =>  const MainPages(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
  ];
}
