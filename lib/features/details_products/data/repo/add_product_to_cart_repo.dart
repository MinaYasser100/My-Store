import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/firebase/firebase_firestore_error_handler.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/utils/constant.dart';
import 'package:my_store/features/details_products/data/service/details_my_cart_services.dart';

abstract class AddProductToCartRepo {
  Future<Either<String, void>> addProductToCart({
    required ProductModel productModel,
    required int quantity,
  });
}

class AddProductToCartRepoImpl implements AddProductToCartRepo {
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;
  final UserHiveHelper userHiveHelper;
  final DetailsMyCartServices myCartServices;

  AddProductToCartRepoImpl({
    required this.firestoreErrorHandler,
    required this.userHiveHelper,
    required this.myCartServices,
  });
  @override
  Future<Either<String, void>> addProductToCart({
    required ProductModel productModel,
    required int quantity,
  }) async {
    try {
      final userModel = userHiveHelper.getUser(ConstantVariable.uId);

      await myCartServices.addOrUpdateProductInCart(
        userModel!,
        productModel,
        quantity,
      );
      return const Right(null);
    } on FirebaseException catch (e) {
      final errorMessage = firestoreErrorHandler.mapFirebaseFirestoreException(
        e,
      );
      return Left(errorMessage);
    } catch (e) {
      return Left('Adding to cart failed');
    }
  }
}
