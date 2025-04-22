import 'package:desafio_capyba/features/auth/controllers/auth_controller.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:desafio_capyba/shared/utils/responsive.dart';
import 'package:desafio_capyba/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({super.key});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16),
        height: _controller.isLogin ? 350 : 400,
        width: Responsive.screenWidth(context) * 0.75,
        child: Form(
          key: _controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                style: AppTextStyles.style,
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _controller.authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains("@")) {
                    return 'Informe um e-mail válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: AppTextStyles.style,
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
                      style: AppTextStyles.style,
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
                Column(
                  children: [
                    ButtonWidget(
                      onPressed: () => _controller.submit(
                        context,
                        () => setState(() => _controller.isLoading = true),
                        () => setState(() => _controller.isLoading = false),
                      ),
                      isLoading: _controller.isLoading,
                      child: Text(
                        _controller.isLogin ? "Entrar" : "Registrar",
                        style: AppTextStyles.style,
                      ),
                    ),
                    ButtonWidget(
                      onPressed: () => _controller.loginWithGoogle(
                        context,
                        () => setState(() => _controller.isLoading = true),
                        () => setState(() => _controller.isLoading = false),
                      ),
                      isLoading: _controller.isLoading,
                      child: Text(
                        "Entrar com Google",
                        style: AppTextStyles.style,
                      ),
                    )
                  ],
                ),
              TextButton(
                onPressed: () =>
                    _controller.toggleAuthMode(() => setState(() {})),
                child: Text(
                  _controller.isLogin ? "CADASTRAR" : "JÁ POSSUO CONTA",
                  style: AppTextStyles.style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
