import 'package:get/get.dart';

import '../models/product.dart';
import 'product_controller.dart';

class UserProductsController extends GetxController
    with StateMixin<List<Product>> {
  ProductController productController = Get.find();

  Future<void> refreshProducts() async {
    await productController.fetchAndSetProducts(true);
    change(productController.products.value, status: RxStatus.success());
  }
}
