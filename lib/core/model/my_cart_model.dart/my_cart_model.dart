import 'package:cloud_firestore/cloud_firestore.dart';

class MyCartModel {
  final String productId;
  final int quantity;
  final FieldValue addedAt;

  MyCartModel({
    required this.productId,
    required this.quantity,
    required this.addedAt,
  });

  factory MyCartModel.fromMap(Map<String, dynamic> map) {
    return MyCartModel(
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
      addedAt: map['addedAt'] as FieldValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {'productId': productId, 'quantity': quantity, 'addedAt': addedAt};
  }
}
