class ProductModel {
  final id;
  final title;
  final price;
  final description;
  final category;
  final image;
  final rating;
  int quanitity;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.quanitity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'],
    );
  }

  ProductModel copyWith({
    final id,
    final title,
    final price,
    final description,
    final category,
    final image,
    final rating,
    final quanitity = 0,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      quanitity: quanitity ?? this.quanitity,
    );
  }

  @override
  String toString() {
    return [id, title, price, description, category, image, rating, quanitity]
        .toString();
  }
}
