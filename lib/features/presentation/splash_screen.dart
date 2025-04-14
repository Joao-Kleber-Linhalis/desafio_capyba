import 'package:desafio_capyba/core/routes/app_routes.dart';
import 'package:desafio_capyba/shared/constants/images_path.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImagesPath.logo,
              fit: BoxFit.contain,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
