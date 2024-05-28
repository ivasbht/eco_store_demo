import 'package:eco_store_demo/const_files/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacementNamed(context, AppRoutes.home_screen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitRotatingCircle(
            color: Colors.blueAccent,
            size: 50.0,
          ),
          Text(
            "\nLoading...",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
