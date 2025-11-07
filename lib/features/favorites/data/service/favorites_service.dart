import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/utils/constant.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserHiveHelper userHiveHelper;

  FavoritesService({required this.userHiveHelper});

  Stream<List<ProductModel>> getFavoriteProducts() {
    final userModel = userHiveHelper.getUser(ConstantVariable.uId);
    if (userModel == null) return Stream.value([]);

    return _firestore
        .collection(ConstantVariable.users)
        .doc(userModel.uid)
        .collection(ConstantVariable.likesCollection)
        .orderBy('likedAt', descending: true)
        .snapshots()
        .asyncMap((likesSnapshot) async {
          if (likesSnapshot.docs.isEmpty) return <ProductModel>[];

          final intIds = likesSnapshot.docs
              .map(
                (doc) => int.tryParse(doc.data()['productId'] as String? ?? ''),
              )
              .whereType<int>()
              .toList();

          if (intIds.isEmpty) return <ProductModel>[];

          // Firebase whereIn limit is 10, so batch if needed
          if (intIds.length <= 10) {
            final snapshot = await _firestore
                .collection(ConstantVariable.productsCollection)
                .where('id', whereIn: intIds)
                .get();

            final productsMap = {
              for (var doc in snapshot.docs)
                ProductModel.fromJson(doc.data()).id: ProductModel.fromJson(
                  doc.data(),
                ),
            };

            return intIds
                .map((id) => productsMap[id])
                .whereType<ProductModel>()
                .toList();
          }

          // Batch queries for >10 items
          final batches = <Future<QuerySnapshot<Map<String, dynamic>>>>[];
          for (var i = 0; i < intIds.length; i += 10) {
            batches.add(
              _firestore
                  .collection(ConstantVariable.productsCollection)
                  .where('id', whereIn: intIds.skip(i).take(10).toList())
                  .get(),
            );
          }

          final results = await Future.wait(batches);
          final productsMap = {
            for (var snapshot in results)
              for (var doc in snapshot.docs)
                ProductModel.fromJson(doc.data()).id: ProductModel.fromJson(
                  doc.data(),
                ),
          };

          return intIds
              .map((id) => productsMap[id])
              .whereType<ProductModel>()
              .toList();
        });
  }
}
