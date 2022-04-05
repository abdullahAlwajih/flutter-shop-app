import 'package:super_repository/super_repository.dart';

abstract class AppServices {
  static Future<void> initServices() async {
    await SuperRepository.init();
  }
}
