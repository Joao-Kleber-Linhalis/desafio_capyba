import 'package:desafio_capyba/shared/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/exceptions/auth_exception.dart';
import '../../auth/provider/auth_provider.dart';

enum AuthMode { Signup, Login }

class AuthController {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  final authData = {
    'email': '',
    'password': '',
  };

  bool isLoading = false;
  AuthMode authMode = AuthMode.Login;

  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  late Animation<Offset> slideAnimation;

  bool get isLogin => authMode == AuthMode.Login;

  void initAnimations(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );
  }

  void toggleAuthMode(VoidCallback setStateCallback) {
    if (isLogin) {
      authMode = AuthMode.Signup;
      animationController.forward();
    } else {
      authMode = AuthMode.Login;
      animationController.reverse();
    }

    setStateCallback();
  }

  Future<void> submit(
    BuildContext context,
    VoidCallback startLoading,
    VoidCallback stopLoading,
  ) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    formKey.currentState?.save();

    startLoading();
    final auth = Provider.of<AuthProvider>(context, listen: false);

    try {
      if (isLogin) {
        await auth.login(authData['email']!, authData['password']!);
      } else {
        await auth.signup(authData['email']!, authData['password']!);
      }
    } on AuthException catch (e) {
      Tools.showErrorDialog(e.toString(), context);
    } catch (_) {
      Tools.showErrorDialog("Ocorreu um erro inesperado.", context);
    }
    stopLoading();
  }

  void dispose() {
    passwordController.dispose();
    animationController.dispose();
  }
}
