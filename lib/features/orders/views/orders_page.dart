import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_controller.dart';
import 'components/order_item.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Order")),
      body: controller.obx(
          (orders) => ListView.builder(
              itemCount: orders?.length,
              itemBuilder: (BuildContext context, int index) =>
                  OrderItem(orders![index])),
          onLoading: const Center(child: CircularProgressIndicator()),
          onError: (message) => Center(child: Text(message.toString()))),
    );
  }
}
