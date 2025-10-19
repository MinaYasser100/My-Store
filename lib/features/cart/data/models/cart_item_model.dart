class CartItemModel {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String image;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  double get itemTotal => price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json, String id) {
    final double price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : (json['price'] ?? 0.0);
    final int quantity = (json['quantity'] ?? 1) is int
        ? json['quantity'] as int
        : int.parse((json['quantity'] ?? '1').toString());
    return CartItemModel(
      id: id,
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      price: price,
      image: json['image'] ?? '',
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    String? image,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
