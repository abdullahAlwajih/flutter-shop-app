import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/providers/app_urls.dart';
import '../../products/models/product.dart';

class FavoritesController extends GetxController {
  var product = Rxn<Product>();

  void setFavValue(bool newValue) => product.value?.isFavorite = newValue;

  Future<void> toggleFavoriteStatus(String? token, String? userId) async {
    bool oldStatus = product.value?.isFavorite ?? false;
    product.value?.isFavorite = !(product.value!.isFavorite);

    final url =
        '${AppUrls.userFavorites}/$userId/${product.value?.id}.json?auth=$token';
    try {
      final res = await http.put(Uri.parse(url),
          body: json.encode(product.value?.isFavorite));
      if (res.statusCode >= 400) setFavValue(oldStatus);
    } catch (_) {
      setFavValue(oldStatus);
    }
  }
}
