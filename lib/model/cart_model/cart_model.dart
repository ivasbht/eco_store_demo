import 'package:hive/hive.dart';

class CartModel extends HiveObject {
  final productId;
  final quantity;

  CartModel({
    this.productId,
    this.quantity,
  });

  factory CartModel.fromJson(dynamic json) {
    return CartModel(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "quantity": quantity,
    };
  }
}
