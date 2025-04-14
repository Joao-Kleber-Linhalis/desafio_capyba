import 'package:desafio_capyba/features/auth/presentation/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:desafio_capyba/features/auth/provider/auth_provider.dart'
    as my_auth; // Já existe um AuthProvider no proprio provider, é necessário importar com outro nome para evitar uso do errado.

class AuthOrHomeScreen extends StatefulWidget {
  const AuthOrHomeScreen({super.key});

  @override
  State<AuthOrHomeScreen> createState() => _AuthOrHomeScreenState();
}

class _AuthOrHomeScreenState extends State<AuthOrHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: my_auth.AuthProvider.authStateChanges(),
          builder: (context, snapshot) {
            // Verifica o estado da autenticação
            if (snapshot.connectionState == ConnectionState.active) {
              // Se o usuário estiver autenticado
              if (snapshot.hasData) {
                //return const HomeScreen(); // Tela inicial ou navegação para o app
              } else {
                return AuthScreen();
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
