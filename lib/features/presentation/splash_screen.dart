import 'package:desafio_capyba/shared/constants/images_path.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
