import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_repository/super_repository.dart';

import '../../../core/providers/app_urls.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/utils/toast_bar.dart';
import '../models/user.dart';

enum AuthMode { signIn, signUp }

class UserController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final SuperRepository _repository = SuperRepository.instance;

  AuthMode authMode = AuthMode.signIn;
  var isLoading = false;

  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> opacityAnimation;

  late GlobalKey<FormState> formKey;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  String? _token;
  DateTime? _expiryDate;
  String? userID;
  String? _userId;
  Timer? _authTimer;

  bool get isAuth => token != null;

  String? get userId => _userId;

  String? get token {
    if (_expiryDate != null &&
        _token != null &&
        (_expiryDate?.isAfter(DateTime.now()) ?? false)) return _token;
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    AuthService.getCurrentUser();
    formKey = GlobalKey();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    slideAnimation = Tween<Offset>(
            begin: const Offset(0, -0.15), end: const Offset(0, 0))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }

  Future<void> signUp(String email, String password) async {
    try {
      final body = User.toSignUp(email, password);
      final Request request = Request(url: AppUrls.signUp, body: body);
      AuthService.setCurrentUser(
          await _repository.sendData(request: request, model: User()));
    } catch (e) {
      showToastBar(message: (e as ErrorModel).message);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final body = User.toSignUp(email, password);
      final Request request =
          Request(url: AppUrls.signInWithPassword, body: body);
      AuthService.setCurrentUser(
          await _repository.sendData(request: request, model: User()));
    } catch (e) {
      showToastBar(message: (e as ErrorModel).message);
    }
  }

  // Future<bool> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('userData')) return false;
  //
  //   final Map<String, Object> extractedData =
  //       json.decode(prefs.getString('userData')!) as Map<String, Object>;
  //
  //   final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);
  //   if (expiryDate.isBefore(DateTime.now())) return false;
  //
  //   _token = extractedData['token'] as String?;
  //   _userId = extractedData['userId'] as String?;
  //   _expiryDate = expiryDate;
  //   notifyListeners();
  //   _autoLogout();
  //   return true;
  // }

  Future<void> signOut() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    // notifyListeners();
    // await SharedPreferences.getInstance().clear();
  }

  void autoSignOut() {
    if (_authTimer != null) _authTimer?.cancel();
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(days: timeToExpiry), signOut);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    isLoading = true;
    update();
    try {
      authMode == AuthMode.signIn
          ? signIn(emailController.text, passwordController.text)
          : signUp(emailController.text, passwordController.text);
    } catch (_) {}

    isLoading = false;
    update();
  }

  //
  // void showErrorDialog(String message) {
  //   showDialog(
  //     context: Get.context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('An Error Occurred!'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           child: const Text('Okay!'),
  //           onPressed: () => Navigator.of(ctx).pop(),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  void switchAuthMode() {
    if (authMode == AuthMode.signIn) {
      authMode = AuthMode.signUp;
      update();
      controller.forward();
    } else {
      authMode = AuthMode.signIn;
      update();
      controller.reverse();
    }
  }
}
