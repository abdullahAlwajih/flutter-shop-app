import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class AuthPage extends GetView<UserController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(215, 117, 255, 0.5),
                    Color.fromRGBO(255, 188, 117, 0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1]),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 94),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.shade900,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text('My Shop ',
                            style: context.textTheme.headline3?.copyWith(color: Get.theme.colorScheme.surface))),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 8.0,
                      child:                                GetBuilder<UserController>(
                          builder: (logic) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                        height:
                            controller.authMode == AuthMode.signUp ? 320 : 260,
                        constraints: BoxConstraints(
                            minHeight: controller.authMode == AuthMode.signUp
                                ? 320
                                : 260),
                        width: deviceSize.width * 0.75,
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: controller.formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'E-Mail'),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: controller.emailController,
                                  // validator: (val) {
                                  //   if (val!.isEmpty || !val.contains('@')) {
                                  //     return 'Invalid email!';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
                                  obscureText: true,
                                  controller: controller.passwordController,
                                  // validator: (val) {
                                  //   if (val!.isEmpty || val.length < 5) {
                                  //     return 'Password is too short!';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                 AnimatedContainer(
                                  constraints: BoxConstraints(
                                      minHeight:
                                          controller.authMode == AuthMode.signUp
                                              ? 60
                                              : 0,
                                      maxHeight:
                                          controller.authMode == AuthMode.signUp
                                              ? 120
                                              : 0),
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                  child: FadeTransition(
                                    opacity: controller.opacityAnimation,
                                    child: SlideTransition(
                                      position: controller.slideAnimation,
                                      child: TextFormField(
                                        enabled: controller.authMode ==
                                            AuthMode.signUp,
                                        decoration: const InputDecoration(
                                            labelText: 'Confirm Password'),
                                        obscureText: true,
                                        validator: controller.authMode ==
                                                AuthMode.signUp
                                            ? (val) {
                                                if (val !=
                                                    controller
                                                        .passwordController
                                                        .text) {
                                                  return 'Password do not match!';
                                                }
                                                return null;
                                              }
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                if (controller.isLoading)
                                  const CircularProgressIndicator(),
                                ElevatedButton(
                                  child: Text(
                                      controller.authMode == AuthMode.signIn
                                          ? 'LOGIN'
                                          : 'SIGNUP'),
                                  onPressed: controller.submit,
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 8)),
                                  ),
                                ),
                                TextButton(
                                  child: Text(
                                      '${controller.authMode == AuthMode.signIn ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                                  onPressed: controller.switchAuthMode,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
