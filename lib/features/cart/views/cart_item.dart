import 'package:flutter/material.dart';
import 'package:flutter_shop_app/features/cart/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartItem extends StatelessWidget {
  final String? id;
  final String? productId;
  final double? price;
  final int? quantity;
  final String? title;

   const CartItem(
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title, {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title!),
            subtitle: Text('Total \$${(price! * quantity!)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => cartController.removeItem(productId),
      confirmDismiss: (direction) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text('Do you want to remove item from the cart?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }
}
