import 'package:desafio_capyba/core/routes/app_routes.dart';
import 'package:desafio_capyba/features/presentation/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.SPLASH: (context) => const SplashScreen(),
      },
    );
  }
}
