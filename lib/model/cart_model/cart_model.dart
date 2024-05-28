class CartModel {
  final id;
  final userId;
  final date;
  final List<ProductInCartModel> products;

  CartModel({
    this.id,
    this.userId,
    this.date,
    this.products = const [],
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final List<ProductInCartModel> productLocal = [];
    try {
      (json["products"] as List).forEach((prodQuantity) {
        productLocal.add(ProductInCartModel.fromJson(prodQuantity));
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
}

class ProductInCartModel {
  final productId;
  final quantity;

  ProductInCartModel({
    this.productId,
    this.quantity,
  });

  factory ProductInCartModel.fromJson(Map<String, dynamic> json) {
    return ProductInCartModel(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}
