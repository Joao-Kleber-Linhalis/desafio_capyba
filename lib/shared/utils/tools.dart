import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tools {
  static String formatDateToString(DateTime dateTime) {
    // Define o formato de saída
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    // Retorna a data formatada como String
    return dateFormat.format(dateTime);
  }

  static void showErrorDialog(String msg, BuildContext context) {
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
  
}
