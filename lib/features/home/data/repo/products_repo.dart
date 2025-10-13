import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_store/core/firebase/firebase_firestore_error_handler.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/utils/constant.dart';

abstract class ProductsRepo {
  Stream<Either<String, List<ProductModel>>> getAllProducts();
}

class ProductsRepoImpl implements ProductsRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;

  ProductsRepoImpl({required this.firestoreErrorHandler});
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
    } on FirebaseException catch (e) {
      final errorMessage = firestoreErrorHandler.mapFirebaseFirestoreException(
        e,
      );
      return Stream.value(Left(errorMessage));
    } catch (e) {
      return Stream.value(const Left('Failed to fetch products'));
    }
  }
}
