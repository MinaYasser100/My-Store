class Routes {
  // Singleton instance
  static final Routes _instance = Routes._internal();

  // Private constructor
  Routes._internal();

  // Factory constructor to return the same instance
  factory Routes() {
    return _instance;
  }

  // Static route constants
  static const String registerView = '/register';
  static const String loginView = '/login';
  static const String homeView = '/home';
  static const String checkoutview = '/checkout_view';
  static const String paymentView = '/payment_view';
  static const String forgotPasswordView = '/forgot-password';
  static const String verifyEmailView = '/verify-email';
  static const String classesView = '/classes';
  static const String classView = '/class';
  static const String settingsView = '/settings';
  static const String layoutView = '/layout';
  static const String detailsProductView = '/details-product';
  static const String cartView = '/cart';
}
