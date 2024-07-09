import 'package:eco_store_demo/UI/initial_screen/splash_screen/splash_screen.dart';
import 'package:eco_store_demo/const_files/app_routes/app_routes.dart';
import 'package:eco_store_demo/const_files/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco Store Demo',
      theme: AppTheme.appThemeData,
      home: const SplashScreen(),
      onGenerateRoute: (settings) => AppRoutes.animateRoute(settings),
    );
  }
}
