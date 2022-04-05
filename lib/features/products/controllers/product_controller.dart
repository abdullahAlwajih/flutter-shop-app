import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/providers/app_urls.dart';
import '../models/product.dart';

enum FilterOption { kFavorites, kAll }

class ProductController extends GetxController {
  var products = Rxn<List<Product>>();

  var showOnlyFavorites = Rx<bool>(false);
  var key = GlobalKey<ScaffoldState>();
  String? authToken;
  String? userId;

  @override
  void onInit() async {
    super.onInit();
    await fetchAndSetProducts();
  }

  List<Product?> get favoritesItems =>
      products.value!.where((prodItem) => prodItem.isFavorite).toList();

  Product? findById(String? id) =>
      products.value!.firstWhere((prod) => prod.id == id);

  onSelected(FilterOption selectedValue) => showOnlyFavorites.value =
  (selectedValue == FilterOption.kFavorites ? true : false);


  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    var url = '${AppUrls.products}.json?auth=$authToken&$filterString';

    try {
      final res = await http.get(Uri.parse(url));
      final extractedData = json.decode(res.body) as Map<String, dynamic>?;
      if (extractedData == null) return;
      url = '${AppUrls.userFavorites}/$userId.json?auth=$authToken';

      final favRes = await http.get(Uri.parse(url));
      final favData = json.decode(favRes.body);
      final List<Product> loadedProducts = [];

      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: favData == null ? false : favData[prodId] ?? false,
            imageUrl: prodData['imageUrl'],
          ),
        );
      });
      products.value = loadedProducts;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = '${AppUrls.products}.json?auth=$authToken';
    try {
      final res = await http.post(Uri.parse(url),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          }));
      final newProduct = Product(
        id: json.decode(res.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
      );
      products.value!.add(newProduct);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String? id, Product? newProduct) async {
    final prodIndex = products.value!.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = '${AppUrls.products}/$id.json?auth=$authToken';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct!.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      products.value![prodIndex] = newProduct;
    }
  }

  Future<void> deleteProduct(String? id) async {
    final url = '${AppUrls.products}/$id.json?auth=$authToken';
    final existingProductIndex =
        products.value!.indexWhere((prod) => prod.id == id);
    dynamic existingProduct = products.value![existingProductIndex];
    products.value!.removeAt(existingProductIndex);

    final res = await http.delete(Uri.parse(url));
    if (res.statusCode >= 400) {
      products.value!.insert(existingProductIndex, existingProduct);
      throw Exception('Could not delete Product.');
    }
    existingProduct = null;
  }
}
