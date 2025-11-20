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
    final double price = double.tryParse(json['price'] ?? '0') ?? 0.0;

    final int quantity = json['quantity'] ?? 1;
    final int productId = json['productId'] ?? 0;

    return CartItemModel(
      id: id,
      productId: productId,
      title: json['title'] ?? '',
      price: price,
      image: json['image'] ?? '',
      quantity: quantity,
    );
  }
}
