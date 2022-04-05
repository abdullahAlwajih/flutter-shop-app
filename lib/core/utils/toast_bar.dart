import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToastBar(
    {required String message, IconData? iconData, bool success = false}) {
  Get.snackbar(
    '',
    message,
    titleText: const SizedBox.shrink(),
    backgroundColor:
        success ? const Color(0xff39CC60) : const Color(0xffFF434F),
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(message,
              style: Theme.of(Get.context!)
                  .textTheme
                  .subtitle2
                  ?.copyWith(color: Colors.white)),
        ),
        Icon(
          iconData ?? (success ? Icons.check : Icons.error_outline),
          color: Theme.of(Get.context!).scaffoldBackgroundColor,
        )
      ],
    ),
  );
}
