
import 'package:desafio_capyba/features/auth/presentation/widgets/auth_form_widget.dart';
import 'package:desafio_capyba/shared/constants/images_path.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImagesPath.login,
                  fit: BoxFit.contain,
                ),
                AuthFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
