import 'package:flutter/material.dart';
import 'package:flutter_shop_app/features/products/controllers/product_controller.dart';
import 'package:flutter_shop_app/features/products/models/product.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  ProductController productController = Get.find();

  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageUrlFocusNode = FocusNode();

  final imageUrlController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Product? editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  // var initialValues = {
  //   'title': '',
  //   'description': '',
  //   'price': '',
  //   'imageUrl': '',
  // };
  var isLoading = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    imageUrlFocusNode.addListener(_updateImageUrl);
    final productId = Get.arguments as String?;
    if (productId != null) {
      editedProduct = productController.findById(productId);
      // initialValues = {
      //   'title': editedProduct!.title.toString(),
      //   'description': editedProduct!.description.toString(),
      //   'price': editedProduct!.price.toString(),
      //   'imageUrl': '',
      // };
      imageUrlController.text = editedProduct!.imageUrl!;
    }
  }

  void _updateImageUrl() {
    if (!imageUrlFocusNode.hasFocus) {
      if ((!imageUrlController.text.startsWith('http') &&
              !imageUrlController.text.startsWith('https')) ||
          (!imageUrlController.text.endsWith('.png') &&
              !imageUrlController.text.endsWith('.jpg') &&
              !imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      // setState(() {});
    }
  }

  Future<void> saveForm() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    isLoading.value = true;
    if (editedProduct!.id != null) {
      await productController.updateProduct(editedProduct!.id, editedProduct);
    } else {
      try {
        await productController.addProduct(editedProduct!);
      } catch (e) {
        await Get.dialog(
          AlertDialog(
            title: const Text('An error occurred!'),
            content: const Text('Something went wrong.'),
            actions: [
              TextButton(
                child: const Text('Okay!'),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
      }
    }
    isLoading.value = false;
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
    imageUrlFocusNode.removeListener(_updateImageUrl);
    priceFocusNode.dispose();
    imageUrlFocusNode.dispose();
    imageUrlController.dispose();
    descriptionFocusNode.dispose();
  }
}
