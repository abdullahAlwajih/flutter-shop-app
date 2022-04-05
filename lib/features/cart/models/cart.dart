import 'package:super_repository/app/models/base_model.dart';

class Cart extends BaseModel {
  String? id;
  String? title;
  int? quantity;
  double? price;

  Cart({
    this.id,
    this.title,
    this.quantity,
    this.price,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'quantity': quantity,
        'price': price,
      };

  factory Cart.fromMap(Map<String, dynamic> map) => Cart(
        id: map['id'] as String,
        title: map['title'] as String,
        quantity: map['quantity'] as int? ?? 0,
        price: map['price'] as double?,
      );

  @override
  BaseModel fromJson(Map<String, dynamic> json) => Cart.fromMap(json);

  @override
  List<BaseModel> fromJsonList(List json) =>
      json.map((item) => fromJson(item)).toList();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
