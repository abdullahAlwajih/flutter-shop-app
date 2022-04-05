import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_products_controller.dart';
import '../components/user_product_item.dart';

class UserProductsPage extends GetView<UserProductsController> {
  const UserProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Products"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(EditProductScreen.routeName),
            ),
          ],
        ),
        body: controller.obx(
            (state) => RefreshIndicator(
                  onRefresh: () => controller.refreshProducts(),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: controller.state?.length,
                      itemBuilder: (_, int index) => Column(
                        children: [
                          UserProductItem(
                            controller.state![index].id,
                            controller.state![index].title,
                            controller.state![index].imageUrl,
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
                ),
            onLoading: const Center(child: CircularProgressIndicator())));
  }
}
