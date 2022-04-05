import 'package:super_repository/app/models/base_model.dart';

import '../../cart/models/cart.dart';

class Order extends BaseModel {
  String? id;
  double? amount;
  List<Cart>? products;
  DateTime? dateTime;

  Order({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });

  factory Order.fromMap(Map<String, dynamic> map) => Order(
        id: map['id'] as String,
        amount: map['amount'] as double?,
        products:  map['products'].map((item) => Cart.fromMap(item)).toList(),
        dateTime: DateTime.parse(map['dateTime']),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'amount': amount,
        'products': products,
        'dateTime': dateTime,
      };

  @override
  BaseModel fromJson(Map<String, dynamic> json) => Order.fromMap(json);

  @override
  List<BaseModel> fromJsonList(List json) =>
      json.map((item) => Order.fromMap(item)).toList();

  @override
  Map<String, dynamic> toJson() => toMap();
}
