import 'package:desafio_capyba/features/auth/provider/auth_provider.dart';
import 'package:desafio_capyba/shared/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyEmailWidget extends StatefulWidget {
  final VoidCallback onVerified;

  const VerifyEmailWidget({super.key, required this.onVerified});

  @override
  State<VerifyEmailWidget> createState() => _VerifyEmailWidgetState();
}

class _VerifyEmailWidgetState extends State<VerifyEmailWidget> {
  bool emailSented = false;
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          emailSented
              ? "Já verificou? Click abaixo para atualizar seu usuário"
              : 'Verifique seu e-mail para ter acesso',
          textAlign: TextAlign.center,
          style: AppTextStyles.style,
        ),
        ElevatedButton(
          onPressed: () async {
            if (emailSented) {
              await _authProvider.reloadAuth();
              widget.onVerified();
              return;
            }
            await _authProvider.sendEmailVerification();
            setState(() {
              emailSented = true;
            });
          },
          child: Text(
            emailSented ? 'Atualizar usuário' : 'Enviar e-mail de verificação',
          ),
        ),
      ],
    );
  }
}
