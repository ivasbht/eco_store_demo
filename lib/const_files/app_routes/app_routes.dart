import 'package:eco_store_demo/UI/application_screen/cart_screen/cart_screen.dart';
import 'package:eco_store_demo/UI/application_screen/home_screen/home_screen.dart';
import 'package:eco_store_demo/UI/initial_screen/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash_screen = '/splash_screen';
  static const String home_screen = "/home_screen";
  static const String cart_screen = "/cart_screen";

  static Route animateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home_screen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: routeSettings,
        );
      case cart_screen:
        return MaterialPageRoute(
          builder: (_) => CartScreen(),
          settings: routeSettings,
        );
      default:
       return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: routeSettings,
        ); 
    }
  }
}
