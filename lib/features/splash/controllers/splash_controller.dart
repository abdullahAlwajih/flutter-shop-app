import 'package:flutter_shop_app/core/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit()async {
    super.onInit();
    AuthService.getCurrentUser();
    // Get.offNamed(AppRoutes.main);
  }
}
