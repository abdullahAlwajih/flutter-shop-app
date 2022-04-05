import 'package:get/get.dart';
import 'package:super_repository/super_repository.dart';

import '../../features/user/models/user.dart';
import '../providers/app_urls.dart';

abstract class AuthService extends GetxService {
  static final _local = SuperRepository.provider.local;
  static var currentUser = Rxn<User>();

  static Future getCurrentUser() async {
    User user = User.fromMap(await _local.get(key: AppUrls.signInWithPassword));
    dynamic d =user.getExpiresDate();
    if (user.getExpiresDate().isAfter(DateTime.now())) {
      currentUser.value = user;
    }
  }

  static User? setCurrentUser(User? user) {
    if (user != null) {
      _local.save(key: AppUrls.signInWithPassword, value: user.toJson());
      currentUser.value = user;
      return currentUser.value;
    }
    return null;
  }

  static void removeCurrentUser() {
    currentUser.value = User();
    // await _usersRepo.signOut();
    _local.delete(key: AppUrls.signInWithPassword);
  }

  String? get apiToken => currentUser.value?.token;
}
