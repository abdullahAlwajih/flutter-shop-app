import 'package:flutter/material.dart';
import 'package:flutter_shop_app/features/cart/views/add_order_button.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import 'cart_item.dart';

class CartPage extends GetView<CartController> {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${controller.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  const AddOrderButton(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: controller.carts.value.length,
              itemBuilder: (ctx, int index) => CartItem(
                controller.carts.value.values.toList()[index].id,
                controller.carts.value.keys.toList()[index],
                controller.carts.value.values.toList()[index].price,
                controller.carts.value.values.toList()[index].quantity,
                controller.carts.value.values.toList()[index].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


