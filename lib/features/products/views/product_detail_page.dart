import 'package:flutter/material.dart';
import 'package:flutter_shop_app/features/products/controllers/product_details_controller.dart';
import 'package:get/get.dart';

class ProductDetailPage extends GetView<ProductDetailsController> {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(controller.loadedProduct.title ?? ''),
              background: Hero(
                tag: controller.loadedProduct.id!,
                child: Image.network(controller.loadedProduct.imageUrl!,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 10),
                Text(
                  '\$${controller.loadedProduct.price}',
                  style: const TextStyle(color: Colors.grey, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    controller.loadedProduct.description!,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
