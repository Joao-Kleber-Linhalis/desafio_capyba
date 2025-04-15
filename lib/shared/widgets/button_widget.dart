import 'package:desafio_capyba/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isLoading;

  const ButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: AppColors.buttonBackgroundColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 8,
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : child,
    );
  }
}
