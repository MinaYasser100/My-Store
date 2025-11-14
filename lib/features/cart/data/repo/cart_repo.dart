import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item_model.dart';

class CartRepo {
  final FirebaseFirestore firestore;

  CartRepo({required this.firestore});

  Stream<List<CartItemModel>> getUserCart(String userId) {
    return firestore
        .collection('Users')
        .doc(userId)
        .collection('MyCart')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CartItemModel.fromJson(doc.data(), doc.id))
            .toList());
  }

 
  Future<void> updateQuantity(String userId, String itemId, int quantity) async {
    await firestore
        .collection('Users')
        .doc(userId)
        .collection('MyCart')
        .doc(itemId)
        .update({'quantity': quantity});
  }

 

  Future<void> deleteFromCart(String userId, String itemId) async {
    await firestore
        .collection('Users')
        .doc(userId)
        .collection('MyCart')
        .doc(itemId)
        .delete();
  }

  Future<void> clearCart(String userId) async {
    final cartRef = firestore
        .collection('Users')
        .doc(userId)
        .collection('MyCart');
    final snapshot = await cartRef.get();
    if (snapshot.docs.isEmpty) return;
    final batch = firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
