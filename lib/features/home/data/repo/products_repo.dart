import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/utils/constant.dart';

abstract class ProductsRepo {
  Stream<Either<String, List<ProductModel>>> getAllProducts();
}

class ProductsRepoImpl implements ProductsRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Stream<Either<String, List<ProductModel>>> getAllProducts() {
    try {
      return _firebaseFirestore
          .collection(ConstantVariable.productsCollection)
          .snapshots()
          .map((snapshot) {
            final products = snapshot.docs
                .map((doc) => ProductModel.fromJson(doc.data()))
                .toList();
            return Right(products);
          });
    } catch (e) {
      return Stream.value(Left('Failed to fetch products: ${e.toString()}'));
    }
  }
}
