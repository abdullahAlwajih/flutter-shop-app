import 'package:flutter/material.dart';
import 'package:flutter_shop_app/core/routes/app_routes.dart';
import 'package:get/get.dart';

class ProductsList extends StatelessWidget {
  final List products;

  const ProductsList(this.products, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Center(child: Text("There is no product!"))
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: products.length,
            itemBuilder: (ctx, index) => productItem(context, products[index]),
          );
  }

  Widget productItem(BuildContext context, product) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () =>
              Get.toNamed(AppRoutes.productDetail, arguments: product.id),
          child: Hero(
            tag: product.id!,
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () =>
                product.toggleFavoriteStatus(authData.token, authData.userId),
          ),
          title: Text(product.title!, textAlign: TextAlign.center),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Added to cart!"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO!',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
