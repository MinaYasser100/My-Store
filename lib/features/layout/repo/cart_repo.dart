import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/utils/constant.dart';

abstract class CartRepo {
  Stream<int> getTotalQuantity();
}

class CartRepoImpl implements CartRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserHiveHelper userHiveHelper;

  CartRepoImpl({
    required this.userHiveHelper,
  });

  String? get _userId => userHiveHelper.getUser(ConstantVariable.uId)?.uid;

  CollectionReference _getCartCollection() {
    if (_userId == null) throw Exception('User not logged in');
    return _firestore
        .collection(ConstantVariable.users)
        .doc(_userId)
        .collection(ConstantVariable.myCartCollection);
  }

  @override
  Stream<int> getTotalQuantity() {
    try {
      if (_userId == null) {
        return Stream.value(0);
      }

      return _getCartCollection().snapshots().map((snapshot) {
        int total = 0;
        for (var doc in snapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          total += (data['quantity'] as int?) ?? 0;
        }
        return total;
      });
    } catch (e) {
      return Stream.value(0);
    }
  }
}
