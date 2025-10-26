import 'package:get_it/get_it.dart';
import 'package:my_store/core/caching/hive/user_hive_helper.dart';
import 'package:my_store/core/caching/shared/shared_perf_helper.dart';
import 'package:my_store/core/firebase/firebase_auth_error_handling.dart';
import 'package:my_store/core/firebase/firebase_firestore_error_handler.dart';
import 'package:my_store/core/internet_check/cubit/internet_check__cubit.dart';
import 'package:my_store/features/details_products/data/repo/add_product_to_cart_repo.dart';
import 'package:my_store/features/details_products/data/service/details_my_cart_services.dart';
import 'package:my_store/features/layout/repo/cart_repo.dart';
import 'package:my_store/features/forgot_password/data/repo/forgot_password_repo_impl.dart';
import 'package:my_store/features/home/data/repo/add_to_cart_repo.dart';
import 'package:my_store/features/home/data/repo/like_product_repo.dart';
import 'package:my_store/features/home/data/repo/products_repo.dart';
import 'package:my_store/features/home/data/service/my_cart_services.dart';
import 'package:my_store/features/login/data/repo/login_repo_impl.dart';
import 'package:my_store/features/register/data/repo/register_repo_impl.dart';
import 'package:my_store/features/verfiy_email/data/repo/verify_email_repo_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  getIt.registerSingleton<FirebaseAuthErrorHandling>(
    FirebaseAuthErrorHandling(),
  );

  getIt.registerSingleton<SharedPrefHelper>(SharedPrefHelper.instance);

  getIt.registerSingleton<FirebaseFirestoreErrorHandler>(
    FirebaseFirestoreErrorHandler(),
  );

  getIt.registerSingleton<UserHiveHelper>(UserHiveHelper());

  getIt.registerSingleton<RegisterRepoImpl>(
    RegisterRepoImpl(
      errorHandling: getIt<FirebaseAuthErrorHandling>(),
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
    ),
  );

  getIt.registerSingleton<LoginRepoImpl>(
    LoginRepoImpl(
      errorHandling: getIt<FirebaseAuthErrorHandling>(),
      userHiveHelper: getIt<UserHiveHelper>(),
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
      sharedPrefHelper: getIt<SharedPrefHelper>(),
    ),
  );

  getIt.registerSingleton<ForgotPasswordRepoImpl>(
    ForgotPasswordRepoImpl(getIt<FirebaseAuthErrorHandling>()),
  );

  getIt.registerSingleton<VerifyEmailRepoImpl>(
    VerifyEmailRepoImpl(errorHandling: getIt<FirebaseAuthErrorHandling>()),
  );

  // register connectivity cubit for internet
  getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());

  getIt.registerSingleton<ProductsRepoImpl>(
    ProductsRepoImpl(
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
    ),
  );

  getIt.registerSingleton<LikeProductRepoImpl>(
    LikeProductRepoImpl(
      userHiveHelper: getIt<UserHiveHelper>(),
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
    ),
  );

  getIt.registerSingleton<CartRepoImpl>(
    CartRepoImpl(userHiveHelper: getIt<UserHiveHelper>()),
  );

  getIt.registerSingleton<DetailsMyCartServices>(DetailsMyCartServices());

  getIt.registerSingleton<AddProductToCartRepoImpl>(
    AddProductToCartRepoImpl(
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
      userHiveHelper: getIt<UserHiveHelper>(),
      myCartServices: getIt<DetailsMyCartServices>(),
    ),
  );

  getIt.registerSingleton<MyCartServices>(MyCartServices());
  getIt.registerSingleton<AddOrUpdateProductToCartRepoImpl>(
    AddOrUpdateProductToCartRepoImpl(
      firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
      userHiveHelper: getIt<UserHiveHelper>(),
      myCartServices: getIt<MyCartServices>(),
    ),
  );
}
