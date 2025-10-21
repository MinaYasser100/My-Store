import 'package:cloud_firestore/cloud_firestore.dart';

class MyCartModel {
  final int productId;
  final int quantity;
  final FieldValue addedAt;
  final String title;
  final String price;

  MyCartModel({
    required this.productId,
    required this.quantity,
    required this.addedAt,
    required this.title,
    required this.price,
  });

  factory MyCartModel.fromMap(Map<String, dynamic> map) {
    return MyCartModel(
      productId: map['productId'] as int,
      quantity: map['quantity'] as int,
      addedAt: map['addedAt'] as FieldValue,
      title: map['title'] as String,
      price: map['price'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
      'addedAt': addedAt,
      'title': title,
      'price': price,
    };
  }
}
