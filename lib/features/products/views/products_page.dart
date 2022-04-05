import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.key,
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton<FilterOption>(
            onSelected: controller.onSelected,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOption.kFavorites),
              const PopupMenuItem(
                  child: Text('Show All'), value: FilterOption.kAll),
            ],
          ),
        ],
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
