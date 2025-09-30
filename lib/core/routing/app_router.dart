import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/animation_route.dart';
import 'package:my_store/core/routing/routes.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: Routes.loginView,
    routes: [
      // Register view
      // GoRoute(
      //   path: Routes.registerView,
      //   pageBuilder: (context, state) => fadeTransitionPage(),
      // ),
      // // Login view
      // GoRoute(
      //   path: Routes.loginView,
      //   pageBuilder: (context, state) => fadeTransitionPage(LoginView()),
      // ),
      // // Home view
      // GoRoute(
      //   path: Routes.homeView,
      //   pageBuilder: (context, state) => fadeTransitionPage(HomeView()),
      // ),
      // // Forgot Password
      // GoRoute(
      //   path: Routes.forgotPasswordView,
      //   pageBuilder: (context, state) =>
      //       fadeTransitionPage(ForgotPasswordView()),
      // ),
      // // Verify Email
      // GoRoute(
      //   path: Routes.verifyEmailView,
      //   pageBuilder: (context, state) => fadeTransitionPage(VerifyEmailView()),
      // ),
      // // Classes View
      // GoRoute(
      //   path: Routes.classesView,
      //   pageBuilder: (context, state) {
      //     final level = state.extra as LevelModel?;
      //     if (level == null) throw Exception('Level is not found');
      //     return fadeTransitionPage(ClassesView(level: level));
      //   },
      // ),
      // // Class View
      // GoRoute(
      //   path: Routes.classView,
      //   pageBuilder: (context, state) {
      //     final classModel = state.extra as ClassModel?;
      //     if (classModel == null) throw Exception('class is not found');
      //     return fadeTransitionPage(ClassView(classModel: classModel));
      //   },
      // ),
      // // Settings View
      // GoRoute(
      //   path: Routes.settingsView,
      //   pageBuilder: (context, state) => fadeTransitionPage(SettingsView()),
      // ),
    ],
  );
}

// Future<String> getFirstScreen() async {
//   final isOnboardingSeen = OnboardingHive().isOnboardingSeen();
//   if (!isOnboardingSeen) {
//     return Routes.onboarding;
//   }
//   // Ensure MonitoringSystemHiveService is ready
//   final monitoringService =
//       await GetIt.I.getAsync<MonitoringSystemHiveService>();
//   final farmOwnerStatus = monitoringService.getFarmOwnerStatus();

//   if (farmOwnerStatus == null) {
//     return Routes.userTypeSelectionScreen;
//   } else if (!farmOwnerStatus) {
//     return Routes.layoutScreens;
//   } else if (farmOwnerStatus &&
//       monitoringService.getFarmerSelectedPlants().isEmpty) {
//     return Routes.plantsSelectionScreen;
//   } else {
//     return Routes.layoutScreens;
//   }
// }
