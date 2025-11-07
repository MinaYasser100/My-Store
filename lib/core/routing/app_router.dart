import 'package:go_router/go_router.dart';
import 'package:my_store/core/caching/shared/shared_perf_helper.dart';
import 'package:my_store/core/model/product_model/product_model.dart';
import 'package:my_store/core/routing/animation_route.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/core/utils/constant.dart';
import 'package:my_store/features/cart/ui/cart_view.dart';
import 'package:my_store/features/details_products/ui/details_product_view.dart';
import 'package:my_store/features/forgot_password/ui/forgot_password_view.dart';
import 'package:my_store/features/home/ui/home_view.dart';
import 'package:my_store/features/layout/ui/layout_view.dart';
import 'package:my_store/features/login/ui/login_view.dart';
import 'package:my_store/features/register/ui/register_view.dart';
import 'package:my_store/features/verfiy_email/ui/verify_email_view.dart';
import 'package:my_store/features/profile/ui/profile_screen.dart';
import 'package:my_store/features/profile/ui/personal_info_screen.dart';
import 'package:my_store/features/profile/ui/saved_addresses_screen.dart';
import 'package:my_store/features/profile/ui/add_address_screen.dart';

abstract class AppRouter {
  static GoRouter get router => GoRouter(
    initialLocation: checkLogin() ? Routes.layoutView : Routes.loginView,
    routes: [
      //Register view
      GoRoute(
        path: Routes.registerView,
        pageBuilder: (context, state) => fadeTransitionPage(RegisterView()),
      ),
      // Login view
      GoRoute(
        path: Routes.loginView,
        pageBuilder: (context, state) {
          bool fromVerifyEmail = state.extra as bool? ?? false;
          return fadeTransitionPage(
            LoginView(fromVerifyEmail: fromVerifyEmail),
          );
        },
      ),
      // Home view
      GoRoute(
        path: Routes.homeView,
        pageBuilder: (context, state) => fadeTransitionPage(HomeView()),
      ),
      // Forgot Password
      GoRoute(
        path: Routes.forgotPasswordView,
        pageBuilder: (context, state) =>
            fadeTransitionPage(ForgotPasswordView()),
      ),
      // Verify Email
      GoRoute(
        path: Routes.verifyEmailView,
        pageBuilder: (context, state) => fadeTransitionPage(VerifyEmailView()),
      ),
      // Layout View
      GoRoute(
        path: Routes.layoutView,
        pageBuilder: (context, state) => fadeTransitionPage(LayoutView()),
      ),
      // Details Product View
      GoRoute(
        path: Routes.detailsProductView,
        pageBuilder: (context, state) {
          final product = state.extra as ProductModel;
          return fadeTransitionPage(DetailsProductView(product: product));
        },
      ),
      GoRoute(
        path: Routes.cartView,
        pageBuilder: (context, state) => fadeTransitionPage(CartView()),
      ),
      // Profile View
GoRoute(
  path: Routes.profileView,
  pageBuilder: (context, state) => fadeTransitionPage(ProfileScreen()),
),

// Personal Info View
GoRoute(
  path: Routes.personalInfoView,
  pageBuilder: (context, state) => fadeTransitionPage(PersonalInfoScreen()),
),

// Saved Addresses View
GoRoute(
  path: Routes.savedAddressesView,
  pageBuilder: (context, state) => fadeTransitionPage(SavedAddressesScreen()),
),
GoRoute(
  path: Routes.addAddressView,
  pageBuilder: (context, state) => fadeTransitionPage(AddAddressScreen()),
),


    ],
  );

  static checkLogin() {
    bool isLoginPref =
        SharedPrefHelper.instance.getBool(ConstantVariable.isLogin) ?? false;
    return isLoginPref;
  }
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
