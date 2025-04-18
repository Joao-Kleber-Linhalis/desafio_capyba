import 'package:desafio_capyba/features/auth/presentation/screens/auth_screen.dart';
import 'package:desafio_capyba/features/index/presentation/index_screen.dart';
import 'package:desafio_capyba/features/profile/presentation/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Já existe um AuthProvider no proprio firebase_auth, é necessário importar com outro nome para evitar uso do errado.
import 'package:desafio_capyba/features/auth/provider/auth_provider.dart'
    as my_auth;
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: my_auth.AuthProvider.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final user = snapshot.data;
            if (user == null) {
              return const AuthScreen();
            }
            return FutureBuilder(
              future: Provider.of<my_auth.AuthProvider>(context, listen: false)
                  .loadUserModel(),
              builder: (context, userModelSnapshot) {
                if (userModelSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final authProvider =
                    Provider.of<my_auth.AuthProvider>(context, listen: false);
                final userModel = authProvider.userModel;

                if (userModel.isEmpty) {
                  return const ProfileScreen(
                    isEditMode: false,
                  );
                } else {
                  return const IndexScreen();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
