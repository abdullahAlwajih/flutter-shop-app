import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/providers/app_urls.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/models/cart.dart';
import '../models/order.dart';

class OrderController extends GetxController with StateMixin<List<Order>> {
  final CartController cartController = Get.find();

  String? authToken;
  String? userId;
  var isLoading = Rx(false);

  @override
  void onInit() async {
    super.onInit();
    await fetchAndSetOrders();
  }

  Future<void> fetchAndSetOrders() async {
    final url = '${AppUrls.orders}/$userId.json?auth=$authToken';

    try {
      final res = await http.get(Uri.parse(url));
      final extractedData = json.decode(res.body) as Map<String, dynamic>?;
      if (extractedData == null) return;

      final List<Order> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(
          Order(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => Cart(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      title: item['title'],
                    ))
                .toList(),
          ),
        );
      });
      change(loadedOrders.reversed.toList(), status: RxStatus.success());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrder() async {
    List<Cart> cartProduct = cartController.carts.value.values.toList();
    double total = cartController.totalAmount;
    isLoading.value = true;

    final url = '${AppUrls.orders}/$userId.json?auth=$authToken';
    try {
      final timestamp = DateTime.now();
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'dateTime': timestamp.toIso8601String(),
            'products': cartProduct
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));
      state!.insert(
          0,
          Order(
            id: json.decode(res.body)['name'],
            amount: total,
            dateTime: timestamp,
            products: cartProduct,
          ));
      cartController.carts.value.clear();
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = true;
    }
  }
}
