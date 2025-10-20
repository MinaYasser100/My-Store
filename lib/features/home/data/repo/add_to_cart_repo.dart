import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/firebase/firebase_firestore_error_handler.dart';
import 'package:my_store/core/utils/constant.dart';
import 'package:my_store/features/home/data/service/my_cart_services.dart';

abstract class AddToCartRepo {
  Future<Either<String, void>> addToCart({
    required String productId,
    required int quantity,
  });
}

class AddToCartRepoImpl implements AddToCartRepo {
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;
  final UserHiveHelper userHiveHelper;
  final MyCartServices myCartServices;

  AddToCartRepoImpl({
    required this.firestoreErrorHandler,
    required this.userHiveHelper,
    required this.myCartServices,
  });
  @override
  Future<Either<String, void>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final userModel = userHiveHelper.getUser(ConstantVariable.uId);

      await myCartServices.addOrUpdateProductInCart(userModel!, productId);
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
