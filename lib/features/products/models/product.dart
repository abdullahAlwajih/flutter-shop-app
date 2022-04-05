import 'package:super_repository/app/models/base_model.dart';

class Product extends BaseModel {
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'isFavorite': isFavorite,
      };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        price: map['price'] as double,
        imageUrl: map['imageUrl'] as String,
        isFavorite: map['isFavorite'] as bool,
      );

  @override
  BaseModel fromJson(Map<String, dynamic> json) => Product.fromMap(json);

  @override
  List<BaseModel> fromJsonList(List json) =>
      json.map((item) => fromJson(item)).toList();

  @override
  Map<String, dynamic> toJson() => toMap();

}
