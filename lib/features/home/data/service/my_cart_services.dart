import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_store/core/model/my_cart_model.dart/my_cart_model.dart';
import 'package:my_store/core/model/user_model/user_model.dart';
import 'package:my_store/core/utils/constant.dart';

class MyCartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateProductInCart(
    UserModel userModel,
    String productId,
  ) async {
    final docRef = _firestore
        .collection(ConstantVariable.users)
        .doc(userModel.uid)
        .collection(ConstantVariable.myCartCollection)
        .doc(productId);

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final currentQuantity = (docSnapshot.data()?['quantity'] ?? 0) as int;
      await docRef.update({'quantity': currentQuantity + 1});
    } else {
      final myCartModel = MyCartModel(
        productId: productId,
        quantity: 1,
        addedAt: FieldValue.serverTimestamp(),
      );
      await docRef.set(myCartModel.toMap());
    }
  }
}
