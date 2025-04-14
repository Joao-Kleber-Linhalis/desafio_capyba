import 'package:desafio_capyba/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget>
    with SingleTickerProviderStateMixin {
  final style = const TextStyle(color: Colors.black);
  late final AuthController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AuthController();
    _controller.initAnimations(this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Ocorreu um Erro"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Fechar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16),
        height: _controller.isLogin ? 310 : 400,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                style: style,
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) =>
                    _controller.authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains("@")) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: style,
                decoration: const InputDecoration(labelText: "Senha"),
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _controller.passwordController,
                onSaved: (password) =>
                    _controller.authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 5) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _controller.isLogin ? 0 : 60,
                  maxHeight: _controller.isLogin ? 0 : 120,
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _controller.opacityAnimation,
                  child: SlideTransition(
                    position: _controller.slideAnimation,
                    child: TextFormField(
                      style: style,
                      decoration:
                          const InputDecoration(labelText: "Confirmar Senha"),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: _controller.isLogin
                          ? null
                          : (_password) {
                              final password = _password ?? '';
                              if (password !=
                                  _controller.passwordController.text) {
                                return 'Senhas não conferem';
                              }
                              return null;
                            },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_controller.isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                  onPressed: () => _controller.submit(
                    context,
                    () => setState(() => _controller.isLoading = true),
                    () => setState(() => _controller.isLoading = false),
                    _showErrorDialog,
                  ),
                  child: Text(
                    _controller.isLogin ? "Entrar" : "Registrar",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              TextButton(
                onPressed: () =>
                    _controller.toggleAuthMode(() => setState(() {})),
                child: Text(
                  _controller.isLogin ? "CADASTRAR" : "JÁ POSSUO CONTA",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}