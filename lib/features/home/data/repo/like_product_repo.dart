import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/firebase/firebase_firestore_error_handler.dart';
import 'package:my_store/core/utils/constant.dart';

abstract class LikeProductRepo {
  Future<Either<String, String>> likeProduct(String productId);
  Future<Either<String, String>> unlikeProduct(String productId);
  Stream<bool> isProductLiked(String productId);
}

class LikeProductRepoImpl implements LikeProductRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserHiveHelper userHiveHelper;
  final FirebaseFirestoreErrorHandler firestoreErrorHandler;

  LikeProductRepoImpl({
    required this.userHiveHelper,
    required this.firestoreErrorHandler,
  });

  @override
  Future<Either<String, String>> likeProduct(String productId) async {
    try {
      final userModel = userHiveHelper.getUser(ConstantVariable.uId);

      await _firestore
          .collection(ConstantVariable.users)
          .doc(userModel!.uid)
          .collection(ConstantVariable.likesCollection)
          .doc(productId)
          .set({
            'productId': productId,
            'likedAt': FieldValue.serverTimestamp(),
          });

      return const Right('Product liked successfully');
    } on FirebaseException catch (e) {
      return Left(firestoreErrorHandler.mapFirebaseFirestoreException(e));
    } catch (e) {
      return const Left('Liking Product Failed');
    }
  }

  @override
  Future<Either<String, String>> unlikeProduct(String productId) async {
    try {
      final userModel = userHiveHelper.getUser(ConstantVariable.uId);

      if (userModel == null) {
        return const Left('User not found');
      }

      await _firestore
          .collection(ConstantVariable.users)
          .doc(userModel.uid)
          .collection(ConstantVariable.likesCollection)
          .doc(productId)
          .delete();

      return const Right('Product removed from favorites');
    } on FirebaseException catch (e) {
      return Left(firestoreErrorHandler.mapFirebaseFirestoreException(e));
    } catch (e) {
      return const Left('Removing product from favorites failed');
    }
  }

  @override
  Stream<bool> isProductLiked(String productId) {
    final userModel = userHiveHelper.getUser(ConstantVariable.uId);

    if (userModel == null) {
      return Stream.value(false);
    }

    return _firestore
        .collection(ConstantVariable.users)
        .doc(userModel.uid)
        .collection(ConstantVariable.likesCollection)
        .doc(productId)
        .snapshots()
        .map((snapshot) => snapshot.exists);
  }
}
