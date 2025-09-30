import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() async {
  // getIt.registerSingleton<FirebaseAuthErrorHandling>(
  //   FirebaseAuthErrorHandling(),
  // );

  // getIt.registerSingleton<SharedPrefHelper>(SharedPrefHelper.instance);

  // getIt.registerSingleton<FirebaseFirestoreErrorHandler>(
  //   FirebaseFirestoreErrorHandler(),
  // );

  // getIt.registerSingleton<UserHiveHelper>(UserHiveHelper());

  // getIt.registerSingleton<RegisterRepoImpl>(
  //   RegisterRepoImpl(
  //     errorHandling: getIt<FirebaseAuthErrorHandling>(),
  //     firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
  //   ),
  // );

  // getIt.registerSingleton<LoginRepoImpl>(
  //   LoginRepoImpl(
  //     errorHandling: getIt<FirebaseAuthErrorHandling>(),
  //     sharedPrefHelper: getIt<SharedPrefHelper>(),
  //     userHiveHelper: getIt<UserHiveHelper>(),
  //     firestoreErrorHandler: getIt<FirebaseFirestoreErrorHandler>(),
  //   ),
  // );

  // getIt.registerSingleton<ForgotPasswordRepoImpl>(
  //   ForgotPasswordRepoImpl(getIt<FirebaseAuthErrorHandling>()),
  // );

  // getIt.registerSingleton<VerifyEmailRepoImpl>(
  //   VerifyEmailRepoImpl(errorHandling: getIt<FirebaseAuthErrorHandling>()),
  // );

  // getIt.registerSingleton<LevelRepoImpl>(
  //   LevelRepoImpl(getIt<FirebaseFirestoreErrorHandler>()),
  // );

  // getIt.registerSingleton<ClassesRepoImpl>(
  //   ClassesRepoImpl(getIt<FirebaseFirestoreErrorHandler>()),
  // );

  // // register connectivity cubit for internet
  // getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
}
