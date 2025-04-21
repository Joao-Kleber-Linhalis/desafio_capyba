import 'package:desafio_capyba/features/auth/provider/auth_provider.dart';
import 'package:desafio_capyba/features/home/models/home_model.dart';
import 'package:desafio_capyba/features/home/provider/home_provider.dart';
import 'package:desafio_capyba/features/restricted/models/restricted_model.dart';
import 'package:desafio_capyba/features/restricted/provider/restricted_provider.dart';
import 'package:desafio_capyba/shared/constants/rarity.dart';
import 'package:desafio_capyba/shared/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateController {
  bool isLoading = false;
  String type = "Home";
  String rarity = Rarity.rarities[0];
  final formKey = GlobalKey<FormState>();

  late bool isEmailVerified;
  late RestrictedProvider restrictedProvider;
  late HomeProvider homeProvider;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late String photoUrl;
  final List<String> types = [
    "Home",
    "Restricted",
  ];

  void verify(BuildContext context) {
    isEmailVerified =
        Provider.of<AuthProvider>(context, listen: false).isEmailVerified;
  }

  CreateController(BuildContext context) {
    verify(context);
    restrictedProvider =
        Provider.of<RestrictedProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    photoUrl = "";
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

    startLoading();
    try {
      if (type == "Home") {
        HomeModel home = HomeModel(
          id: "",
          title: nameController.text,
          description: descriptionController.text,
          imageUrl: "",
        );
        await homeProvider.saveHome(home, photoUrl);
      } else {
        RestrictedModel restricted = RestrictedModel(
          id: "",
          title: nameController.text,
          description: descriptionController.text,
          imageUrl: "",
          rarity: rarity,
        );
        await restrictedProvider.saveRestricted(restricted, photoUrl);
      }
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint(e.toString());
      Tools.showErrorDialog("Erro ao salvar perfil. Tente novamente.", context);
    }
    stopLoading();
  }

  dispose() {
    nameController.dispose();
    descriptionController.dispose();
  }
}
