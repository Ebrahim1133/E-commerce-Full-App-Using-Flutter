import 'package:get/get.dart';

import '../logic/bindings/auth_biniding.dart';
import '../logic/bindings/main_binding.dart';
import '../logic/bindings/product_binding.dart';
import '../view/screens/auth/forget_password_screen.dart';
import '../view/screens/auth/loginin_screen.dart';
import '../view/screens/auth/signup_screen.dart';
import '../view/screens/cart_screen.dart';
import '../view/screens/main_screen.dart';
import '../view/screens/payment_screen.dart';
import '../view/screens/welcome_screen.dart';


class AppRoutes {
  //initialRoute

  static const welcome = Routes.welcomeScreen;
  static const mainSreen = Routes.mainScreen;
  //getPages

  static final routes = [
    GetPage(
      name: Routes.welcomeScreen,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [
        AuthBinding(),
        MainBininding(),
        ProductBinding(),
      ],
    ),
    GetPage(
      name: Routes.cartScreen,
      page: () => CartScreen(),
      bindings: [
        AuthBinding(),
        ProductBinding(),
      ],
    ),
    GetPage(
      name: Routes.paymentScreen,
      page: () => PayMentScreen(),
      bindings: [
        AuthBinding(),
        ProductBinding(),
        MainBininding(),
      ],
    ),
  ];
}

class Routes {
  static const welcomeScreen = '/welcomeScreen';
  static const loginScreen = '/loginScreen';
  static const signUpScreen = '/signUpScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const mainScreen = '/mainScreen';
  static const cartScreen = '/cartScreen';
  static const paymentScreen = '/paymentScreen';
}
