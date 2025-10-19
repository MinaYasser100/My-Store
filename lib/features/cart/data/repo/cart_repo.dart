import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item_model.dart';

class CartRepo {
  final FirebaseFirestore firestore;

  CartRepo({required this.firestore});

  Stream<List<CartItemModel>> getUserCart(String userId) {
    return firestore
        .collection('Users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CartItemModel.fromJson(doc.data(), doc.id))
            .toList());
  }

 
  Future<void> updateQuantity(String userId, String itemId, int quantity) async {
    await firestore
        .collection('Users')
        .doc(userId)
        .collection('cart')
        .doc(itemId)
        .update({'quantity': quantity});
  }

 

  Future<void> deleteFromCart(String userId, String itemId) async {
    await firestore
        .collection('Users')
        .doc(userId)
        .collection('cart')
        .doc(itemId)
        .delete();
  }
}
