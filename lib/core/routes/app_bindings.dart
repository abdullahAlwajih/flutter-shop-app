import 'package:get/get.dart';

import '../../features/settings/controllers/settings_controller.dart';
import '../../features/splash/controllers/splash_controller.dart';
import '../../features/user/controllers/user_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => SplashController());
}

class UserBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => UserController());
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController(), permanent: true);
  }
}
