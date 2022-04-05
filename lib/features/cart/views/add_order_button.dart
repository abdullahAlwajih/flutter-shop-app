import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../orders/controllers/order_controller.dart';

class AddOrderButton extends GetView<OrderController> {
  const AddOrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextButton(
        child: controller.isLoading.value
            ? const CircularProgressIndicator()
            : const Text('ORDER NOW'),
        onPressed: controller.isLoading.value
            ? null
            : () async => await controller.addOrder(),
      );
    });
  }
}
