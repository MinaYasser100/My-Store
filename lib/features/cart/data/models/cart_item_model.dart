class CartItemModel {
  final String id;
  final int productId;
  final String title;
  final double price;
  final String image;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });

  double get itemTotal => price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json, String id) {
    final priceValue = json['price'];
    final double price = priceValue is int
        ? priceValue.toDouble()
        : priceValue is String
        ? double.tryParse(priceValue) ?? 0.0
        : (priceValue as double? ?? 0.0);

    final quantityValue = json['quantity'] ?? 1;
    final int quantity = quantityValue is int
        ? quantityValue
        : int.tryParse(quantityValue.toString()) ?? 1;

    final productIdValue = json['productId'];
    final int productId = productIdValue is int
        ? productIdValue
        : int.tryParse(productIdValue.toString()) ?? 0;

    return CartItemModel(
      id: id,
      productId: productId,
      title: json['title'] ?? '',
      price: price,
      image: json['image'] ?? '',
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  CartItemModel copyWith({
    String? id,
    int? productId,
    String? name,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: name ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
