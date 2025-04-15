import 'dart:io';

import 'package:desafio_capyba/core/services/firebase_service.dart';
import 'package:desafio_capyba/features/auth/provider/auth_provider.dart';
import 'package:desafio_capyba/shared/models/user_model.dart';
import 'package:desafio_capyba/shared/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileController {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  late AuthProvider authProvider;
  late UserModel user;
  late final TextEditingController nameController;
  late DateTime birthDate;
  late String photoUrl;

  ProfileController(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    user = authProvider.userModel;
    nameController = TextEditingController(text: user.name);
    birthDate = user.birthDate;
    photoUrl = user.photoUrl;
  }

  void setPhotoUrl(String url) {
    photoUrl = url;
  }

  Future<void> submit(
    BuildContext context,
    VoidCallback startLoading,
    VoidCallback stopLoading,
  ) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (photoUrl.isEmpty) {
      Tools.showErrorDialog("Selecione uma foto.", context);
      return;
    }
    if (birthDate == DateTime.now()) {
      Tools.showErrorDialog("Selecione uma data de nascimento.", context);
      return;
    }
    startLoading();

    try {
      user = user.copyWith(
        id: authProvider.userId,
        name: nameController.text,
        birthDate: birthDate,
        photoUrl: "",
      );
      await user.save();
      String photoFirebaseUrl = await FirebaseService.instance
              .saveImage(File(photoUrl), user.id, user.collection) ??
          "";
      user = await user.copyWith(photoUrl: photoFirebaseUrl).save();
      await authProvider.loadUserModel();
    } catch (e) {
      debugPrint(e.toString());
      Tools.showErrorDialog("Erro ao salvar perfil. Tente novamente.", context);
    }
    stopLoading();
  }

  dispose() {
    nameController.dispose();
  }
}
