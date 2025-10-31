import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_store/core/model/user_model/user_model.dart';
import 'package:my_store/core/utils/constant.dart';

class UserHiveHelper {
  // Singleton instance
  static final UserHiveHelper _instance = UserHiveHelper._internal();

  // Private constructor
  UserHiveHelper._internal();

  // Factory constructor to return the same instance
  factory UserHiveHelper() => _instance;

  // تهيئة Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    await Hive.openBox<UserModel>(ConstantVariable.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    await box.put(ConstantVariable.uId, user);
  }

  UserModel? getUser(String key) {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    return box.get(key);
  }

  List<UserModel> getAllUsers() {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    return box.values.toList();
  }

  Future<void> deleteUser(String key) async {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    await box.delete(key);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
