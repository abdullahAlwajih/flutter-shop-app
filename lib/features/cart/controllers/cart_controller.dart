import 'package:get/get.dart';

import '../models/cart.dart';

class CartController extends GetxController {
  var carts = Rx<Map<String?, Cart>>({});

  double get totalAmount {
    var total = 0.0;
    carts.value.forEach(
        (key, cartItem) => total += cartItem.price! * cartItem.quantity!);
    return total;
  }

  void addItem(String? productId, double? price, String? title) {
    if (carts.value.containsKey(productId)) {
      carts.value.update(
          productId,
          (existingCartItem) => Cart(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity! + 1));
    } else {
      carts.value.putIfAbsent(
          productId,
          () => Cart(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price));
    }
  }

  void removeItem(String? productId) => carts.value.remove(productId);

  void removeSingleItem(String? productId) {
    if (!carts.value.containsKey(productId)) return;
    if (carts.value[productId]!.quantity! > 1) {
      carts.value.update(
        productId,
        (existingCartItem) => Cart(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity! - 1),
      );
    } else {
      carts.value.remove(productId);
    }
  }

  void clear() => carts.value = {};
}
