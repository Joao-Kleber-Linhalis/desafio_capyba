import 'package:desafio_capyba/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:desafio_capyba/features/auth/provider/auth_provider.dart'
    as my_auth;
import 'package:provider/provider.dart'; // Já existe um AuthProvider no proprio provider, é necessário importar com outro nome para evitar uso do errado.

class AuthOrHomeScreen extends StatefulWidget {
  const AuthOrHomeScreen({super.key});

  @override
  State<AuthOrHomeScreen> createState() => _AuthOrHomeScreenState();
}

class _AuthOrHomeScreenState extends State<AuthOrHomeScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: my_auth.AuthProvider.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;

              if (user != null && !_isLoading) {
                _isLoading = true;
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final authProvider =
                      Provider.of<my_auth.AuthProvider>(context, listen: false);
                  await authProvider.loadUserModel();

                  if (!mounted) return;

                  final userModel = authProvider.userModel;
                  if (userModel.isEmpty) {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.PROFILE_SCREEN);
                  } else {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.HOME_SCREEN);
                  }
                });
                return const Center(child: CircularProgressIndicator());
              } else if (user == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.AUTH_SCREEN);
                });
                return const SizedBox.shrink();
              }
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
