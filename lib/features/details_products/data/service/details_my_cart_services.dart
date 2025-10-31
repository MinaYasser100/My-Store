import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_store/core/model/my_cart_model.dart/my_cart_model.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/model/user_model/user_model.dart';
import 'package:my_store/core/utils/constant.dart';

class DetailsMyCartServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateProductInCart(
    UserModel userModel,
    ProductModel productModel,
    int quantity,
  ) async {
    final docRef = _firestore
        .collection(ConstantVariable.users)
        .doc(userModel.uid)
        .collection(ConstantVariable.myCartCollection)
        .doc(productModel.id.toString());

    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final currentQuantity = (docSnapshot.data()?['quantity'] ?? 0) as int;
      await docRef.update({'quantity': currentQuantity + quantity});
    } else {
      final myCartModel = MyCartModel(
        productId: productModel.id!,
        quantity: quantity,
        addedAt: FieldValue.serverTimestamp(),
        title: productModel.title!,
        price: productModel.price!.toString(),
      );
      await docRef.set(myCartModel.toMap());
    }
  }
}
