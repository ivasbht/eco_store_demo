import 'package:eco_store_demo/model/product_model/product_model.dart';

class CartModel {
  final id;
  final userId;
  final date;
  List<ProductModel> products;

  CartModel({
    this.id,
    this.userId,
    this.date,
    this.products = const [],
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final List<ProductModel> productLocal = [];
    try {
      (json["products"] as List).forEach((prodQuantity) {
        productLocal.add(ProductModel(
          id: prodQuantity['productId'],
          quanitity: int.tryParse(prodQuantity['quantity'].toString()) ?? 0,
        ));
      });
    } catch (_) {}
    //
    //
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: productLocal,
    );
  }

  @override
  String toString() {
    return [id, userId, date, products.toList().toString()]
        .toString();
  }

}
