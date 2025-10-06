import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:my_store/core/routing/animation_route.dart';
import 'package:my_store/core/routing/routes.dart';
import 'package:my_store/features/forgot_password/ui/forgot_password_view.dart';
import 'package:my_store/features/home/ui/home_view.dart';
import 'package:my_store/features/login/ui/login_view.dart';
import 'package:my_store/features/register/ui/register_view.dart';
import 'package:my_store/features/verfiy_email/ui/verify_email_view.dart';

abstract class AppRouter {
  static final router = GoRouter(
    initialLocation: initialRoute(),
    routes: [
      //Register view
      GoRoute(
        path: Routes.registerView,
        pageBuilder: (context, state) => fadeTransitionPage(RegisterView()),
      ),
      // Login view
      GoRoute(
        path: Routes.loginView,
        pageBuilder: (context, state) => fadeTransitionPage(LoginView()),
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
    ],
  );
}

String initialRoute() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return Routes.homeView;
  } else {
    return Routes.registerView;
  }
}
