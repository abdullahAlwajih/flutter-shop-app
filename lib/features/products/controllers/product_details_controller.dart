import 'product_controller.dart';
import 'package:get/get.dart';



class ProductDetailsController extends GetxController {
  ProductController productController = Get.find();
  var loadedProduct;

  @override
  void onInit() {
    super.onInit();
    final productId = Get.arguments as String?;
    loadedProduct = productController.findById(productId)!;
  }


}
